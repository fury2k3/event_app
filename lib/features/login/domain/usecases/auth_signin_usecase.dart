import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthSignInUseCase implements UseCase<String, SignInParams> {
  AuthSignInUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, String>> call(SignInParams signInPrams) async {
    return await repository.signIn(
      email: signInPrams.email,
      password: signInPrams.password,
    );
  }
}

class SignInParams extends Equatable {
  const SignInParams({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
