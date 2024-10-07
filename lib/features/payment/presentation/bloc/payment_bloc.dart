import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:event_app/core/errors/failures.dart';
import 'package:event_app/features/payment/domain/usecases/pay_with_stripe_usecase.dart';
import 'package:event_app/global/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc({
    required PayWithStripeUseCase payWithStripeUseCase,
  })  : _payWithStripeUseCase = payWithStripeUseCase,
        super(PaymentInitial()) {
    on<PaymentEvent>((event, emit) {});

    on<PayWithStripeEvent>(_payWithStripeEvent);
  }

  final PayWithStripeUseCase _payWithStripeUseCase;

  Future<void> _payWithStripeEvent(
    PayWithStripeEvent event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentLoading());
    final result = await _payWithStripeUseCase.call(
      PayWithStripeParams(
        amount: event.amount,
        currency: event.currency,
        customerId: event.customerId,
      ),
    );

    result.fold(
      (failure) {
        emit(
          StripePaymentError(
            message: mapFailureToString(failure),
            isInternetFailure: failure.runtimeType == ConnexionFailure,
          ),
        );
      },
      (success) {
        emit(
          StripePaymentSuccess(intentId: success),
        );
      },
    );
  }
}
