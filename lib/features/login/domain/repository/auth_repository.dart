import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/features/login/data/models/user_info.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> signInWithGoogle();

  Future<Either<Failure, String>> signIn({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> signUp({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  });

  Future<Either<Failure, Unit>> requestResetPassword({
    required String email,
  });

  Future<Either<Failure, Unit>> confirmResetCode({
    required String email,
    required String resetCode,
  });

  Future<Either<Failure, Unit>> updatePassword({
    required String email,
    required String newPassword,
  });

  Future<Either<Failure, Unit>> logOut();

  Future<Either<Failure, bool>> isUserConnected();
  Future<Either<Failure, UserInfo>> getUserInfo();
}
