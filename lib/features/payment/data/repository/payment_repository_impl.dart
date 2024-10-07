import 'package:dartz/dartz.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/core/network/network_info.dart';
import 'package:event_app/features/payment/data/data_source/payment_remote_data_source.dart';
import 'package:event_app/features/payment/domain/repository/payment_repository.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl({
    required this.paymentRemoteDataSource,
    required this.networkInfo,
  });
  final PaymentRemoteDataSource paymentRemoteDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, String?>> payWithStripe({
    required String amount,
    required String currency,
    required String customerId,
  }) async {
    if (await networkInfo.isConnected == false) {
      return Left(ConnexionFailure());
    }
    try {
      final paymentIntentData =
          await paymentRemoteDataSource.createPaymentIntent(
        amount: amount,
        currency: currency,
        customerId: customerId,
      );

      await paymentRemoteDataSource.initPaymentSheet(
        paymentIntentData: paymentIntentData,
      );

      await paymentRemoteDataSource.displayPaymentSheet();
      return Right(paymentIntentData['id'] as String?);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
