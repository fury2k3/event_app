import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/login/data/models/user_info.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';

class GetUserInfoUseCase implements UseCase<UserInfo, NoParams> {
  GetUserInfoUseCase({
    required this.repository,
  });
  final AuthRepository repository;

  @override
  Future<Either<Failure, UserInfo>> call(NoParams params) async {
    return await repository.getUserInfo();
  }
}
