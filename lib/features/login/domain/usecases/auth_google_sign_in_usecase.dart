import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthSignInUseCase implements UseCase<Unit, NoParams> {
  AuthSignInUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams signInPrams) async {
    return await repository.signInWithGoogle();
  }
}
