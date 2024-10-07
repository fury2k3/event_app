import 'package:easy_localization/easy_localization.dart';
import 'package:event_app/core/errors/failures.dart';

String mapFailureToString(Failure failure) {
  if (failure is ServerFailure) {
    return 'Oops! Something went wrong on our end. Please try again later.';
  } else if (failure is ConnexionFailure) {
    return 'No internet connection. Please check your network settings '
        'and try again.';
  } else if (failure is WrongEmailOrPasswordFailure) {
    return 'Invalid credentials.';
  } else if (failure is UserExistFailure) {
    return 'User already exist.';
  } else if (failure is UserNotFoundFailure) {
    return 'The email address you entered is not associated with any account.';
  } else if (failure is InvalidResetCodeFailure) {
    return 'The reset code you entered is invalid or has expired. '
        'Please request a new one.';
  } else if (failure is ResetCodeNotVerifiedFailure) {
    return 'You need to verify the reset code before updating your password.';
  } else {
    return 'An unexpected error occurred. Please try again later or contact '
        'support for assistance.';
  }
}

String formatIsoDate(String isStringDate) {
  final dateTime = DateTime.parse(isStringDate);

  final formatter = DateFormat('dd-MM-yyyy');
  return formatter.format(dateTime.toLocal());
}
