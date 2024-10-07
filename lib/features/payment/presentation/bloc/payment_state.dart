part of 'payment_bloc.dart';

@immutable
abstract class PaymentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class StripePaymentSuccess extends PaymentState {
  final String? intentId;

  StripePaymentSuccess({
    required this.intentId,
  });

  @override
  List<Object?> get props => [intentId];
}

class StripePaymentError extends PaymentState {
  final String message;
  final bool isInternetFailure;

  StripePaymentError({
    required this.message,
    required this.isInternetFailure,
  });

  @override
  List<Object?> get props => [message, isInternetFailure];
}
