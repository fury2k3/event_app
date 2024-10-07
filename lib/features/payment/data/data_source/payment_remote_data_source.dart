import 'dart:convert';

import 'package:event_app/core/errors/exceptions.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as https;

abstract class PaymentRemoteDataSource {
  Future<Map<String, dynamic>> createPaymentIntent({
    required String amount,
    required String currency,
    required String customerId,
  });

  Future<Map<String, dynamic>> initPaymentSheet({
    required Map<String, dynamic> paymentIntentData,
  });

  Future<void> displayPaymentSheet();
}

class PaymentRemoteDataSourceImpl extends PaymentRemoteDataSource {
  PaymentRemoteDataSourceImpl({
    required this.client,
  });
  final https.Client client;

  @override
  Future<Map<String, dynamic>> createPaymentIntent({
    required String amount,
    required String currency,
    required String customerId,
  }) async {
    try {
      final body = <String, dynamic>{
        'amount': amount,
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      final response = await https.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $stripePrivateLiveKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print(response.body);
      print(response.statusCode);

      return jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      print('createPaymentIntent');
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<Map<String, dynamic>> initPaymentSheet({
    required Map<String, dynamic> paymentIntentData,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          style: ThemeMode.dark,
          merchantDisplayName: 'Prospects',
          customerId: paymentIntentData['customer'] as String?,
          paymentIntentClientSecret:
              paymentIntentData['client_secret'] as String?,
          customerEphemeralKeySecret:
              paymentIntentData['ephemeralKey'] as String?,
        ),
      );
      return paymentIntentData;
    } catch (e) {
      print('initPaymentSheet');
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print('displayPaymentSheet');
      print(e.toString());
      throw ServerException();
    }
  }
}
