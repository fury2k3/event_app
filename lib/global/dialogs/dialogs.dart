import 'package:event_app/global/dialogs/two_option_dialog_with_icon.dart';
import 'package:flutter/material.dart';

abstract class AppDialog {
  const AppDialog._();

  static Future<bool> showNoInternetDialog({
    required BuildContext context,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const TwoOptionDialogWithIcon(
          title: 'Notice',
          text: 'No internet connection. Please check your network '
              'settings and try again.',
          icon: Icons.cloud_off,
          disableButtonText: 'Ok',
          confirmButtonText: 'Try Again',
        );
      },
    );
    if (result != null) {
      return result;
    }
    return false;
  }

  static Future<bool> showServerErrorDialog({
    required BuildContext context,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const TwoOptionDialogWithIcon(
          title: 'Notice',
          text:
              'Oops! Something went wrong on our end. Please try again later.',
          icon: Icons.storage,
          disableButtonText: 'Ok',
          confirmButtonText: 'Try Again',
        );
      },
    );
    if (result != null) {
      return result;
    }
    return false;
  }
}
