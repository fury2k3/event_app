// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "app_name": "Event App",
  "next": "NEXT",
  "finish": "FINISH",
  "cancel": "Cancel",
  "choose": "Choose",
  "auth": {
    "username": "User Name",
    "first_name": "First Name",
    "last_name": "Last Name",
    "email": "Email Address",
    "password": "Password",
    "confirm_password": "Confirm Password",
    "forgot_password": "Forgot Password? ",
    "login": "LOG IN",
    "not_having_account": "Don't have an account ? ",
    "join_us": "Join us",
    "sign_in": "Sign In",
    "sign_up": "Sign Up",
    "hint_email": "Enter your email",
    "hint_password": "Enter your password",
    "hint_re_password": "Re-enter your password",
    "hint_username": "Enter your username",
    "hint_first_name": "Enter your first name",
    "hint_last_name": "Enter your last name"
  },
  "settings": {
    "english": "English",
    "french": "French"
  }
};
static const Map<String,dynamic> fr = {
  "app_name": "Event App",
  "next": "NEXT",
  "finish": "FINISH",
  "cancel": "Cancel",
  "choose": "Choose",
  "auth": {
    "username": "User Name",
    "email": "Email Address",
    "first_name": "First Name",
    "last_name": "Last Name",
    "password": "Password",
    "confirm_password": "Confirm Password",
    "forgot_password": "Forgot Password? ",
    "login": "LOG IN",
    "not_having_account": "Don't have an account ? ",
    "join_us": "Join us",
    "sign_in": "Connexion",
    "sign_up": "Sign Up",
    "finish": "Finish",
    "hint_email": "Enter your email",
    "hint_password": "Enter your password",
    "hint_re_password": "Re-enter your password",
    "hint_username": "Enter your username",
    "hint_first_name": "Enter your first name",
    "hint_last_name": "Enter your last name"
  },
  "settings": {
    "english": "English",
    "french": "French"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en, "fr": fr};
}
