import 'package:event_app/global/theme/theme.dart';
import 'package:flutter/material.dart';

abstract class AppSnackBar {
  static void showSnackBar(
    BuildContext context,
    String message, {
    int? durationInMilliseconds,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: redErrorLoginInputColor,
        content: Text(message),
        duration: Duration(milliseconds: durationInMilliseconds ?? 3000),
      ),
    );
  }

  static void showSuccessSnackBar(
    BuildContext context,
    String message, {
    int? durationInMilliseconds,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: successColor,
        content: Text(message),
        duration: Duration(milliseconds: durationInMilliseconds ?? 3000),
      ),
    );
  }
}
