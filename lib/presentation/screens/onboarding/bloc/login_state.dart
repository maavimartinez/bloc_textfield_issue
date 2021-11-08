import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginState extends Equatable {}

class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpSentState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpResentState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingState extends LoginState {
  @override
  List<Object> get props => [];
}

class LoadingVerificationState extends LoginState {
  @override
  List<Object> get props => [];
}

class OtpVerifiedState extends LoginState {
  final User user;

  OtpVerifiedState(this.user);

  User getUser() {
    return user;
  }

  @override
  List<Object> get props => [user];
}

class LoginCompleteState extends LoginState {
  final User user;

  LoginCompleteState(this.user);

  User getUser() {
    return user;
  }

  @override
  List<Object> get props => [user];
}

class ExceptionState extends LoginState {
  final String message;

  ExceptionState({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpExceptionState extends LoginState {
  final String message;

  OtpExceptionState({required this.message});

  @override
  List<Object> get props => [message];
}
