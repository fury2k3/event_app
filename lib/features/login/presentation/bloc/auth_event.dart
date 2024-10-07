part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class AuthSignInEvent extends AuthEvent {
  AuthSignInEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthSignUpEvent extends AuthEvent {
  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
  });
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;

  @override
  List<Object?> get props => [
        email,
        password,
        username,
        firstName,
        lastName,
      ];
}

class SendResetCodeEvent extends AuthEvent {
  SendResetCodeEvent({
    required this.email,
  });
  final String email;

  @override
  List<Object?> get props => [email];
}

class ConfirmResetCodeEvent extends AuthEvent {
  ConfirmResetCodeEvent({
    required this.email,
    required this.resetCode,
  });
  final String email;

  final String resetCode;

  @override
  List<Object?> get props => [resetCode];
}

class UpdatePasswordEvent extends AuthEvent {
  UpdatePasswordEvent({
    required this.email,
    required this.newPassword,
  });
  final String email;

  final String newPassword;

  @override
  List<Object?> get props => [email, newPassword];
}

class GetUserIsConnectedEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LogoutUserEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class GetUserInfoEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
}
