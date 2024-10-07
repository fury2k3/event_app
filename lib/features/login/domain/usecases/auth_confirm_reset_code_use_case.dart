import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class AuthConfirmResetCodeUseCase
    implements UseCase<Unit, ConfirmResetCodeParams> {
  AuthConfirmResetCodeUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(ConfirmResetCodeParams params) async {
    return await repository.confirmResetCode(
      email: params.email,
      resetCode: params.resetCode,
    );
  }
}

class ConfirmResetCodeParams extends Equatable {
  const ConfirmResetCodeParams({
    required this.email,
    required this.resetCode,
  });

  final String email;
  final String resetCode;

  @override
  List<String> get props => [email, resetCode];
}
