abstract class Validation {
  const Validation._();

  static String? validateEmail(String? email) {
    if ((email ?? '').isEmpty) {
      return '';
    }
    if (!_isValidEmail(email ?? '')) {
      return '';
    }
    return null;
  }

  static String? validateText(String? value) {
    if ((value ?? '').isEmpty) {
      return '';
    }

    return null;
  }

  static bool _isValidEmail(String value) {
    final emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$',
    );
    return emailRegex.hasMatch(value);
  }

  static String? validatePassword(String? value) =>
      (value ?? '').isNotEmpty ? null : '';
}
