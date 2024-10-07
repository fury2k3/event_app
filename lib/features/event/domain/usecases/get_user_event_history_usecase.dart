import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/event/data/models/purchase_model.dart';
import 'package:event_app/features/event/domain/repository/event_repository.dart';

class GetUserHistoryEventUseCase
    implements UseCase<List<PurchaseModel>, NoParams> {
  GetUserHistoryEventUseCase({
    required this.repository,
  });
  final EventRepository repository;

  @override
  Future<Either<Failure, List<PurchaseModel>>> call(NoParams params) async {
    return await repository.getEventHistory();
  }
}
