part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSignInFailureState extends AuthState {
  AuthSignInFailureState({
    required this.isInternetFailure,
    required this.message,
  });
  final bool isInternetFailure;
  final String message;
}

class AuthSignUpFailureState extends AuthState {
  AuthSignUpFailureState({
    required this.isInternetFailure,
    required this.message,
  });
  final bool isInternetFailure;
  final String message;
}

class AuthSignInSuccessState extends AuthState {}

class AuthSignUpSuccessState extends AuthState {}

class ResetPasswordFailureState extends AuthState {
  ResetPasswordFailureState({
    required this.isInternetFailure,
    required this.message,
  });
  final bool isInternetFailure;
  final String message;
}

class ResetCodeSendState extends AuthState {}

class ResetCodeSendLoadingState extends AuthState {}

class ResetCodeConfirmedState extends AuthState {}

class ResetCodeConfirmedLoadingState extends AuthState {}

class PasswordUpdatedState extends AuthState {}

class PasswordUpdatedLoadingState extends AuthState {}

class LoggedInState extends AuthState {}

class LoggedOutState extends AuthState {}

class GetUserInfoState extends AuthState {
  GetUserInfoState({
    required this.userInfo,
  });
  final UserInfo userInfo;
}
