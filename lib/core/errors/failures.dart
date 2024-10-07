import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {}

class WrongEmailOrPasswordFailure extends Failure {}

class UserExistFailure extends Failure {}

class ConnexionFailure extends Failure {}

class CacheFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

class InvalidResetCodeFailure extends Failure {}

class ResetCodeNotVerifiedFailure extends Failure {}
