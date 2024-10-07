import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/event/data/models/event_model.dart';
import 'package:event_app/features/event/data/models/purchase_model.dart';
import 'package:event_app/features/event/domain/usecases/create_event_usecase.dart';
import 'package:event_app/features/event/domain/usecases/get_all_events_usecase.dart';
import 'package:event_app/features/event/domain/usecases/get_user_event_history_usecase.dart';
import 'package:event_app/features/event/domain/usecases/make_event_purchase_usecase.dart';
import 'package:event_app/global/utils/functions.dart';
import 'package:flutter/material.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventActions, EventState> {
  EventBloc({
    required CreateEventUseCase createEventUseCase,
    required GetAllEventUseCase getAllEventUseCase,
    required MakeEventPurchaseUseCase makeEventPurchaseUseCase,
    required GetUserHistoryEventUseCase getUserHistoryEventUseCase,
  })  : _createEventUseCase = createEventUseCase,
        _getAllEventUseCase = getAllEventUseCase,
        _makeEventPurchaseUseCase = makeEventPurchaseUseCase,
        _getUserHistoryEventUseCase = getUserHistoryEventUseCase,
        super(EventInitial()) {
    on<CreateEvent>(_createEvent);
    on<GetEventList>(_getEventList);
    on<PurchaseEvent>(_purchaseEvent);
    on<GetEventHistoryList>(_getEventHistoryList);
  }

  final CreateEventUseCase _createEventUseCase;
  final GetAllEventUseCase _getAllEventUseCase;
  final MakeEventPurchaseUseCase _makeEventPurchaseUseCase;
  final GetUserHistoryEventUseCase _getUserHistoryEventUseCase;

  Future<void> _createEvent(
    CreateEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final result = await _createEventUseCase.call(event.eventParams);

    result.fold(
      (failure) {
        emit(
          EventFailure(
            isInternetFailure: failure.runtimeType == ConnexionFailure,
            message: mapFailureToString(failure),
          ),
        );
      },
      (success) {
        emit(EventCreatedSuccessfully());
      },
    );
  }

  Future<void> _getEventList(
    GetEventList event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final result = await _getAllEventUseCase.call(NoParams());

    result.fold(
      (failure) {
        emit(
          EventFailure(
            isInternetFailure: failure.runtimeType == ConnexionFailure,
            message: mapFailureToString(failure),
          ),
        );
      },
      (eventsList) {
        emit(EventListLoaded(eventsList: eventsList));
      },
    );
  }

  Future<void> _purchaseEvent(
    PurchaseEvent event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final result = await _makeEventPurchaseUseCase.call(
      MakeEventPurchaseParams(
        eventId: event.params.eventId,
        nbrTickets: event.params.nbrTickets,
      ),
    );

    result.fold(
      (failure) {
        emit(
          EventFailure(
            isInternetFailure: failure.runtimeType == ConnexionFailure,
            message: mapFailureToString(failure),
          ),
        );
      },
      (success) {
        emit(EventPurchasedSuccessfully());
      },
    );
  }

  Future<void> _getEventHistoryList(
    GetEventHistoryList event,
    Emitter<EventState> emit,
  ) async {
    emit(EventLoading());

    final result = await _getUserHistoryEventUseCase.call(NoParams());

    result.fold(
      (failure) {
        emit(
          EventFailure(
            isInternetFailure: failure.runtimeType == ConnexionFailure,
            message: mapFailureToString(failure),
          ),
        );
      },
      (purchaseList) {
        emit(EventHistoryListLoaded(purchaseList: purchaseList));
      },
    );
  }
}
