import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/data/models/purchase_model.dart';

abstract class EventRepository {
  Future<Either<Failure, Unit>> createEvent({
    required String eventName,
    required String eventDate,
    required String eventLocation,
    required String eventPrice,
    required String eventAvailableTicket,
    required String eventDescription,
    File? eventImage,
  });

  Future<Either<Failure, List<EventModel>>> getAllEvents();

  Future<Either<Failure, Unit>> makeEventPurchase({
    required String eventId,
    required int nbrTickets,
  });

  Future<Either<Failure, List<PurchaseModel>>> getEventHistory();
}
