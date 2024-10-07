import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthSendResetCodeUseCase implements UseCase<Unit, String> {
  AuthSendResetCodeUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(String email) async {
    return await repository.requestResetPassword(
      email: email,
    );
  }
}
