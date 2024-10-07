import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/data/models/user_info.dart';
import 'package:event_app/features/login/domain/usecases/auth_confirm_reset_code_use_case.dart';
import 'package:event_app/features/login/domain/usecases/auth_send_reset_code_use_case.dart';
import 'package:event_app/features/login/domain/usecases/auth_signin_usecase.dart';
import 'package:event_app/features/login/domain/usecases/auth_signup_usecase.dart';
import 'package:event_app/features/login/domain/usecases/auth_update_password_use_case.dart';
import 'package:event_app/features/login/domain/usecases/get_user_info_use_case.dart';
import 'package:event_app/features/login/domain/usecases/get_user_is_connected_use_case.dart';
import 'package:event_app/features/login/domain/usecases/logout_user_use_case.dart';
import 'package:event_app/global/utils/functions.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AuthSignInUseCase authSignInUseCase,
    required AuthSignUpUseCase authSignUpUseCase,
    required AuthSendResetCodeUseCase authSendResetCodeUseCase,
    required AuthConfirmResetCodeUseCase authConfirmResetCodeUseCase,
    required AuthUpdatePasswordUseCase authUpdatePasswordUseCase,
    required GetUserIsConnectedUseCase getUserIsConnectedUseCase,
    required LogoutUserUseCase logoutUserUseCase,
    required GetUserInfoUseCase getUserInfoUseCase,
  })  : _authSignInUseCase = authSignInUseCase,
        _authSignUpUseCase = authSignUpUseCase,
        _authSendResetCodeUseCase = authSendResetCodeUseCase,
        _authConfirmResetCodeUseCase = authConfirmResetCodeUseCase,
        _authUpdatePasswordUseCase = authUpdatePasswordUseCase,
        _getUserIsConnectedUseCase = getUserIsConnectedUseCase,
        _logoutUserUseCase = logoutUserUseCase,
        _getUserInfoUseCase = getUserInfoUseCase,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {});
    on<AuthSignInEvent>(_signInEvent);
    on<AuthSignUpEvent>(_signUpEvent);
    on<SendResetCodeEvent>(_sendResetCodeEvent);
    on<ConfirmResetCodeEvent>(_confirmResetCodeEvent);
    on<UpdatePasswordEvent>(_updatePasswordEvent);
    on<GetUserIsConnectedEvent>(_getUserIsConnectedEvent);
    on<LogoutUserEvent>(_logoutUserEvent);
    on<GetUserInfoEvent>(_getUserInfoEvent);
  }

  final AuthSignInUseCase _authSignInUseCase;
  final AuthSignUpUseCase _authSignUpUseCase;
  final AuthSendResetCodeUseCase _authSendResetCodeUseCase;
  final AuthConfirmResetCodeUseCase _authConfirmResetCodeUseCase;
  final AuthUpdatePasswordUseCase _authUpdatePasswordUseCase;
  final GetUserIsConnectedUseCase _getUserIsConnectedUseCase;
  final LogoutUserUseCase _logoutUserUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;

  Future<void> _signInEvent(
    AuthSignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await _authSignInUseCase.call(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthSignInFailureState(
          isInternetFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToString(failure),
        ),
      ),
      (success) => emit(AuthSignInSuccessState()),
    );
  }

  Future<void> _signUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());

    final result = await _authSignUpUseCase.call(
      SignUpParams(
        email: event.email,
        password: event.password,
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthSignUpFailureState(
          isInternetFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToString(failure),
        ),
      ),
      (success) => emit(AuthSignUpSuccessState()),
    );
  }

  Future<void> _sendResetCodeEvent(
    SendResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ResetCodeSendLoadingState());

    final result = await _authSendResetCodeUseCase.call(event.email);

    result.fold(
      (failure) => emit(
        ResetPasswordFailureState(
          isInternetFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToString(failure),
        ),
      ),
      (success) => emit(
        ResetCodeSendState(),
      ),
    );
  }

  Future<void> _confirmResetCodeEvent(
    ConfirmResetCodeEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(ResetCodeConfirmedLoadingState());

    final result = await _authConfirmResetCodeUseCase.call(
      ConfirmResetCodeParams(
        email: event.email,
        resetCode: event.resetCode,
      ),
    );

    result.fold(
      (failure) => emit(
        ResetPasswordFailureState(
          isInternetFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToString(failure),
        ),
      ),
      (success) => emit(
        ResetCodeConfirmedState(),
      ),
    );
  }

  Future<void> _updatePasswordEvent(
    UpdatePasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(PasswordUpdatedLoadingState());

    final result = await _authUpdatePasswordUseCase.call(
      UpdatePasswordParams(
        email: event.email,
        newPassword: event.newPassword,
      ),
    );

    result.fold(
      (failure) => emit(
        ResetPasswordFailureState(
          isInternetFailure: failure.runtimeType == ConnexionFailure,
          message: mapFailureToString(failure),
        ),
      ),
      (success) => emit(
        PasswordUpdatedState(),
      ),
    );
  }

  Future<void> _getUserIsConnectedEvent(
    GetUserIsConnectedEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getUserIsConnectedUseCase.call(NoParams());

    result.fold(
      (failure) => emit(LoggedOutState()),
      (success) => emit(success ? LoggedInState() : LoggedOutState()),
    );
  }

  Future<void> _logoutUserEvent(
    LogoutUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _logoutUserUseCase.call(NoParams());

    result.fold(
      (failure) => emit(LoggedOutState()),
      (success) => emit(LoggedOutState()),
    );
  }

  Future<void> _getUserInfoEvent(
    GetUserInfoEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _getUserInfoUseCase.call(NoParams());

    result.fold(
      (failure) => emit(LoggedOutState()),
      (userInfo) => emit(
        GetUserInfoState(userInfo: userInfo),
      ),
    );
  }
}
