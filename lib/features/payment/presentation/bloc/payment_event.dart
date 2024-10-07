part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent extends Equatable {}

class PayWithStripeEvent extends PaymentEvent {
  final String amount;
  final String currency;
  final String customerId;

  PayWithStripeEvent({
    required this.amount,
    required this.currency,
    required this.customerId,
  });

  @override
  List<String> get props => [amount, currency, customerId];
}
