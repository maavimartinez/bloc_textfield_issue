import 'dart:io';

import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';

class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SendOtpEvent extends LoginEvent {
  final String phoneNumber;
  final String prefix;

  SendOtpEvent({required this.prefix, required this.phoneNumber});
}

class ResendOtpEvent extends LoginEvent {
  final String phoneNumber;
  final String prefix;
  ResendOtpEvent({required this.prefix, required this.phoneNumber});
}

class AppStartEvent extends LoginEvent {}

class VerifyOtpEvent extends LoginEvent {
  final String otp;

  VerifyOtpEvent({required this.otp});
}

class LogoutEvent extends LoginEvent {}

class OtpSendEvent extends LoginEvent {}

class OtpResendEvent extends LoginEvent {}

class OtpVerifiedEvent extends LoginEvent {
  final User user;
  OtpVerifiedEvent({required this.user});
}

class LoginCompleteEvent extends LoginEvent {
  final User user;
  LoginCompleteEvent({required this.user});
}

class OtpExceptionEvent extends LoginEvent {
  final String message;

  OtpExceptionEvent({required this.message});
}

class LoginExceptionEvent extends LoginEvent {
  final String message;

  LoginExceptionEvent({required this.message});
}

class AccountCreationExceptionEvent extends LoginEvent {
  final String message;

  AccountCreationExceptionEvent({required this.message});
}

class CreateAccountEvent extends LoginEvent {
  final String email;
  final String username;
  final File? avatar;
  final DateTime? birthdate;
  final String fullName;
  CreateAccountEvent(
      {required this.email,
      required this.avatar,
      required this.birthdate,
      required this.fullName,
      required this.username});
}
