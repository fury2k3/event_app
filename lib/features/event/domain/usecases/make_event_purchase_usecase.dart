import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/event/domain/repository/event_repository.dart';

class MakeEventPurchaseUseCase
    implements UseCase<Unit, MakeEventPurchaseParams> {
  MakeEventPurchaseUseCase({
    required this.repository,
  });
  final EventRepository repository;

  @override
  Future<Either<Failure, Unit>> call(MakeEventPurchaseParams params) async {
    return await repository.makeEventPurchase(
      eventId: params.eventId,
      nbrTickets: params.nbrTickets,
    );
  }
}

class MakeEventPurchaseParams extends Equatable {
  const MakeEventPurchaseParams({
    required this.eventId,
    required this.nbrTickets,
  });

  final String eventId;
  final int nbrTickets;

  @override
  List<Object?> get props => [eventId, nbrTickets];
}
