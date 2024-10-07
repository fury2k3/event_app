import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/usecase/usecase.dart';
import 'package:event_app/features/payment/domain/repository/payment_repository.dart';

class PayWithStripeUseCase extends UseCase<String?, PayWithStripeParams> {
  PayWithStripeUseCase({
    required this.paymentRepository,
  });
  final PaymentRepository paymentRepository;

  @override
  Future<Either<Failure, String?>> call(PayWithStripeParams params) async {
    return await paymentRepository.payWithStripe(
      amount: params.amount,
      currency: params.currency,
      customerId: params.customerId,
    );
  }
}

class PayWithStripeParams extends Equatable {
  const PayWithStripeParams({
    required this.amount,
    required this.currency,
    required this.customerId,
  });
  final String amount;
  final String currency;
  final String customerId;

  @override
  List<Object?> get props => [
        amount,
        currency,
        customerId,
      ];
}
