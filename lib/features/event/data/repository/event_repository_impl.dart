import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/exceptions.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/network/network_info.dart';
import 'package:event_app/features/event/data/datasources/remote_data_source/event_remote_data_source.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/data/models/purchase_model.dart';
import 'package:event_app/features/event/domain/repository/event_repository.dart';
import 'package:event_app/features/login/data/data_sources/local_data_source/auth_local_data_source.dart';

class EventRepositoryImpl implements EventRepository {
  EventRepositoryImpl({
    required EventRemoteDataSource eventRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
    required NetworkInfo networkInfo,
  })  : _eventRemoteDataSource = eventRemoteDataSource,
        _authLocalDataSource = authLocalDataSource,
        _networkInfo = networkInfo;

  final EventRemoteDataSource _eventRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, Unit>> createEvent({
    required String eventName,
    required String eventDate,
    required String eventLocation,
    required String eventPrice,
    required String eventAvailableTicket,
    required String eventDescription,
    File? eventImage,
  }) async {
    if (await _networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final userId = await _authLocalDataSource.getUserId();
      if (userId != null) {
        await _eventRemoteDataSource.createEvent(
          userId: userId,
          eventName: eventName,
          eventDate: eventDate,
          eventLocation: eventLocation,
          eventPrice: eventPrice,
          eventAvailableTicket: eventAvailableTicket,
          eventDescription: eventDescription,
          eventImage: eventImage,
        );

        return const Right(unit);
      }

      return Left(WrongEmailOrPasswordFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllEvents() async {
    if (await _networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final eventList = await _eventRemoteDataSource.getAllEvents();

      return Right(eventList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> makeEventPurchase({
    required String eventId,
    required int nbrTickets,
  }) async {
    if (await _networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }

    try {
      final userId = await _authLocalDataSource.getUserId();
      if (userId != null) {
        await _eventRemoteDataSource.makeEventPurchase(
          eventId: eventId,
          userId: userId,
          nbrTickets: nbrTickets,
        );

        return const Right(unit);
      }

      return Left(WrongEmailOrPasswordFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<PurchaseModel>>> getEventHistory() async {
    if (await _networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }

    try {
      final userId = await _authLocalDataSource.getUserId();
      if (userId != null) {
        final historyEvent = await _eventRemoteDataSource.getPurchasesByUser(
          userId: userId,
        );

        return Right(historyEvent);
      }

      return Left(WrongEmailOrPasswordFailure());
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
