import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/exceptions.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/network/network_info.dart';
import 'package:event_app/features/login/data/data_sources/local_data_source/auth_local_data_source.dart';
import 'package:event_app/features/login/data/data_sources/remote_data_source/auth_remote_data_source.dart';
import 'package:event_app/features/login/data/models/user_info.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDataSource,
    required this.networkInfo,
  });

  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String>> signIn({
    required String email,
    required String password,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final response = await authRemoteDataSource.signIn(
        password: password,
        email: email,
      );
      final userInfo = userInfoFromJson(response);
      await authLocalDataSource.saveToken(token: userInfo.token ?? '');
      await authLocalDataSource.saveRole(role: userInfo.role ?? '');
      await authLocalDataSource.saveUserId(userId: userInfo.userId ?? '');

      return Right(userInfo.token ?? '');
    } on ServerException {
      return Left(ServerFailure());
    } on WrongCredentialException {
      return Left(WrongEmailOrPasswordFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signUp({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await authRemoteDataSource.signUp(
        email: email,
        password: password,
        username: username,
        firstName: firstName,
        lastName: lastName,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    } on UserExistException {
      return Left(UserExistFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> requestResetPassword({
    required String email,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await authRemoteDataSource.restPassword(
        email: email,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> confirmResetCode({
    required String email,
    required String resetCode,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await authRemoteDataSource.confirmResetCode(
        email: email,
        resetCode: resetCode,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    } on InvalidResetCodeException {
      return Left(InvalidResetCodeFailure());
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword({
    required String email,
    required String newPassword,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      await authRemoteDataSource.updatePassword(
        email: email,
        newPassword: newPassword,
      );

      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    } on ResetCodeNotVerifiedException {
      return Left(ResetCodeNotVerifiedFailure());
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isUserConnected() async {
    try {
      final token = await authLocalDataSource.getToken();
      final userId = await authLocalDataSource.getUserId();
      return Right(
        (token != null && token.isNotEmpty) &&
            (userId != null && userId.isNotEmpty),
      );
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    try {
      await authLocalDataSource.removeToken();
      await authLocalDataSource.removeRole();
      await authLocalDataSource.removeUserId();
      await authRemoteDataSource.googleSignOut();
      return const Right(unit);
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, UserInfo>> getUserInfo() async {
    try {
      final userInfo = await Future.wait([
        authLocalDataSource.getToken(),
        authLocalDataSource.getUserId(),
        authLocalDataSource.getRole(),
      ]);

      return Right(
        UserInfo(
          token: userInfo[0],
          userId: userInfo[1],
          role: userInfo[2],
        ),
      );
    } on Exception {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
