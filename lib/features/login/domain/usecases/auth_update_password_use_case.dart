import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthUpdatePasswordUseCase implements UseCase<Unit, UpdatePasswordParams> {
  AuthUpdatePasswordUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(UpdatePasswordParams params) async {
    return await repository.updatePassword(
      email: params.email,
      newPassword: params.newPassword,
    );
  }
}

class UpdatePasswordParams extends Equatable {
  const UpdatePasswordParams({
    required this.email,
    required this.newPassword,
  });
  final String email;
  final String newPassword;

  @override
  List<Object?> get props => [email, newPassword];
}
