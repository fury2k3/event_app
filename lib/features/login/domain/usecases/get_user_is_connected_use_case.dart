import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class GetUserIsConnectedUseCase implements UseCase<bool, NoParams> {
  GetUserIsConnectedUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isUserConnected();
  }
}
