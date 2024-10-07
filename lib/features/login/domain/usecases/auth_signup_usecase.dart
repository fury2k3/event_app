import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthSignUpUseCase implements UseCase<Unit, SignUpParams> {
  AuthSignUpUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(SignUpParams params) async {
    return await repository.signUp(
      email: params.email,
      password: params.password,
      username: params.username,
      firstName: params.firstName,
      lastName: params.lastName,
    );
  }
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
  });
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;

  @override
  List<String> get props => [
        email,
        password,
        username,
        firstName,
        lastName,
      ];
}
