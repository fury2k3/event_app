part of 'event_bloc.dart';

@immutable
abstract class EventActions {}

class CreateEvent extends EventActions {
  CreateEvent({
    required this.eventParams,
  });
  final CreateEventParams eventParams;
}

class GetEventList extends EventActions {}

class GetEventHistoryList extends EventActions {}

class PurchaseEvent extends EventActions {
  PurchaseEvent({
    required this.params,
  });
  final MakeEventPurchaseParams params;
}
