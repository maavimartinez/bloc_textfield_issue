import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_event.dart';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  String verID = "";

  LoginBloc(
      {required UserRepository userRepository,
      required AuthenticationBloc authenticationBloc})
      : _userRepository = userRepository,
        _authenticationBloc = authenticationBloc,
        super(InitialLoginState());

  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is SendOtpEvent) {
      yield LoadingState();
      yield* sendOtp(event.phoneNumber);
    }
    if (event is ResendOtpEvent) {
      yield* sendOtp(event.phoneNumber, resend: true);
    } else if (event is OtpSendEvent) {
      yield OtpSentState();
    } else if (event is OtpExceptionEvent) {
      yield OtpExceptionState(message: event.message);
    } else if (event is OtpResendEvent) {
      yield OtpResentState();
    } else if (event is LoginCompleteEvent) {
      yield LoginCompleteState(event.user);
    } else if (event is LoginExceptionEvent) {
      yield ExceptionState(message: event.message);
    } else if (event is VerifyOtpEvent) {
      yield* verifyOTP(event);
    } else if (event is CreateAccountEvent) {
      yield* createAccount(event);
    } else if (event is AccountCreationExceptionEvent) {
      yield ExceptionState(message: event.message);
    }
  }

  Stream<LoginState> verifyOTP(event) async* {
    try {
      yield LoadingVerificationState();
      User user = await _userRepository.verifyAndLogin(verID, event.otp);
      if (user.email == null) {
        yield OtpVerifiedState(user);
      } else {
        _authenticationBloc.add(LoggedIn(user: user));
        yield LoginCompleteState(user);
      }
    } catch (e) {
      print(e);
      yield OtpExceptionState(message: "Invalid otp!");
    }
  }

  Stream<LoginState> createAccount(event) async* {
    try {
      yield LoadingState();
      User? result = await _userRepository.createAccount(
          birthdate: event.birthdate,
          avatar: event.avatar,
          email: event.email,
          username: event.username,
          fullName: event.fullName);
      if (result != null) {
        _authenticationBloc.add(LoggedIn(user: result));
        yield LoginCompleteState(result);
      } else {
        yield ExceptionState(message: "Invalid info");
      }
    } on Exception catch (e) {
      yield ExceptionState(
          message: "${e.toString().replaceFirst('Exception: ', '')}");
    }
  }

  Stream<LoginState> sendOtp(String phoNo, {bool resend = false}) async* {
    try {
      _userRepository
          .sendOTP(
              phone: phoNo,
              timeout: Duration(seconds: 5),
              isResendCodeEvent: false)
          .listen((event) async {
        if (event != null &&
            event['status'] != null &&
            event['status'] == 'phoneCodeSent') {
          this.verID = event['verId'];
          if (resend == true) {
            add(OtpResendEvent());
          } else {
            add(OtpSendEvent());
          }
        } else if (event != null &&
            event['status'] != null &&
            event['status'] == 'phoneVerificationCompleted') {
          final user = await _userRepository.fetchUser(event['uid']);
          add(OtpVerifiedEvent(user: user ?? User(uid: '', phone: '')));
        } else if (event != null && event['exception'] != null) {
          this.verID = event['verId'] ?? '';
          add(LoginExceptionEvent(
              message: "${{
            event['exception']
          }.toString().replaceFirst('Exception: ', '')}"));
        }
      });
    } on Exception catch (e) {
      yield ExceptionState(
          message: "${e.toString().replaceFirst('Exception: ', '')}");
    } catch (e) {
      print(e);
    }
  }

  @override
  void onEvent(LoginEvent event) {
    super.onEvent(event);
    print(event);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    super.onError(error, stacktrace);
    print(stacktrace);
  }

  Future<void> close() async {
    print("Bloc closed");
    super.close();
  }
}
