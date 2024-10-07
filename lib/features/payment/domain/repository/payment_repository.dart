import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';

abstract class PaymentRepository {
  Future<Either<Failure, String?>> payWithStripe({
    required String amount,
    required String currency,
    required String customerId,
  });
}
