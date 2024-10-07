import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/event/domain/repository/event_repository.dart';

class CreateEventUseCase implements UseCase<Unit, CreateEventParams> {
  CreateEventUseCase({
    required this.repository,
  });
  final EventRepository repository;

  @override
  Future<Either<Failure, Unit>> call(CreateEventParams params) async {
    return await repository.createEvent(
      eventName: params.eventName,
      eventDate: params.eventDate,
      eventLocation: params.eventLocation,
      eventPrice: params.eventPrice,
      eventAvailableTicket: params.eventAvailableTicket,
      eventDescription: params.eventDescription,
      eventImage: params.eventImage,
    );
  }
}

class CreateEventParams extends Equatable {
  const CreateEventParams({
    required this.eventName,
    required this.eventDate,
    required this.eventLocation,
    required this.eventPrice,
    required this.eventAvailableTicket,
    required this.eventDescription,
    this.eventImage,
  });

  final String eventName;
  final String eventDate;
  final String eventLocation;
  final String eventPrice;
  final String eventAvailableTicket;
  final String eventDescription;
  final File? eventImage;

  @override
  List<Object?> get props => [];
}
