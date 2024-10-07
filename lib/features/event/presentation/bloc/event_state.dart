part of 'event_bloc.dart';

@immutable
abstract class EventState {}

class EventInitial extends EventState {}

class EventLoading extends EventState {}

class EventFailure extends EventState {
  EventFailure({
    required this.isInternetFailure,
    required this.message,
  });
  final bool isInternetFailure;
  final String message;
}

class EventCreatedSuccessfully extends EventState {}

class EventPurchasedSuccessfully extends EventState {}

class EventListLoaded extends EventState {
  EventListLoaded({
    required this.eventsList,
  });
  final List<EventModel> eventsList;
}

class EventHistoryListLoaded extends EventState {
  EventHistoryListLoaded({
    required this.purchaseList,
  });
  final List<PurchaseModel> purchaseList;
}
