import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/exceptions.dart';
import 'package:event_app/global/utils/app_api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<GoogleSignInAccount?> signInWithGoogle();

  Future<void> googleSignOut();

  Future<Unit> signUp({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  });

  Future<String> signIn({
    required String email,
    required String password,
  });

  Future<Unit> restPassword({
    required String email,
  });

  Future<Unit> confirmResetCode({
    required String email,
    required String resetCode,
  });

  Future<Unit> updatePassword({
    required String email,
    required String newPassword,
  });
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({
    required http.Client client,
    required GoogleSignIn googleSignIn,
  })  : _client = client,
        _googleSignIn = googleSignIn;

  final http.Client _client;
  final GoogleSignIn _googleSignIn;

  @override
  Future<String> signIn({
    required String email,
    required String password,
  }) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'password': password,
    };
    final response = await _client
        .post(
          Uri.parse(loginUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {
      throw WrongCredentialException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> signUp({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'password': password,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
    };

    final response = await _client
        .post(
          Uri.parse(signUpUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    if (response.statusCode == 201) {
      return unit;
    } else if (response.statusCode == 400) {
      throw UserExistException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> restPassword({
    required String email,
  }) async {
    final requestBody = <String, dynamic>{
      'email': email,
    };
    final response = await _client
        .post(
          Uri.parse(forgotPasswordUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> confirmResetCode({
    required String email,
    required String resetCode,
  }) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'resetCode': resetCode,
    };
    final response = await _client
        .post(
          Uri.parse(verifyResetCodedUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400) {
      throw InvalidResetCodeException();
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    final requestBody = <String, dynamic>{
      'email': email,
      'newPassword': newPassword,
    };
    final response = await _client
        .put(
          Uri.parse(resetPasswordUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        )
        .catchError(
          (e) => throw ServerException(),
        );

    if (response.statusCode == 200) {
      return unit;
    } else if (response.statusCode == 400) {
      throw ResetCodeNotVerifiedException();
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    final user = await _googleSignIn.signIn();
    if (user != null) {
      await signUp(
        email: user.email,
        password: 'password',
        username: user.displayName ?? '',
        firstName: user.displayName ?? '',
        lastName: user.displayName ?? '',
      );

      await signIn(email: user.email, password: 'password');

      return user;
    }
    return null;
  }

  @override
  Future<void> googleSignOut() async {
    await _googleSignIn.disconnect();
  }
}
