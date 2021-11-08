import 'dart:ui';

import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_state.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';
import 'package:bloc_textfield_issue/presentation/screens/main_container/home_screen.dart';
import 'package:bloc_textfield_issue/presentation/screens/onboarding/widgets/phone_input.dart';
import 'package:bloc_textfield_issue/presentation/screens/onboarding/widgets/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'bloc/bloc.dart';

class PhoneInputAndVerificationScreen extends StatefulWidget {
  @override
  _PhoneInputAndVerificationScreenState createState() =>
      _PhoneInputAndVerificationScreenState();
}

class _PhoneInputAndVerificationScreenState
    extends State<PhoneInputAndVerificationScreen> {
  String? phone = '';
  String? prefix = '+1';
  //List<String?> otp = List<String?>.filled(6, null);
  String otp = '';

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.show');
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(
                userRepository: GetIt.instance<UserRepository>(),
                authenticationBloc: authenticationBloc),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: BlocListener<LoginBloc, LoginState>(
                    listener: (context, loginState) {
                  if (loginState is LoginCompleteState) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider.value(
                                value: authenticationBloc,
                                child: HomeScreen())),
                        (route) => false);
                  }
                }, child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                  return Container(
                      height: MediaQuery.of(context).size.height -
                          EdgeInsets.fromWindowPadding(
                                  WidgetsBinding.instance?.window.viewInsets ??
                                      WindowPadding.zero,
                                  WidgetsBinding
                                          .instance?.window.devicePixelRatio ??
                                      0)
                              .bottom,
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [_renderInfoAndButton(state, context)],
                      )));
                })))));
  }

  Widget _renderInfoAndButton(state, context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(children: [
        AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: _getViewPerState(state)),
        _renderButton(context, state)
      ]);
    } else {
      return Row(children: [
        AnimatedSwitcher(
            duration: Duration(milliseconds: 600),
            child: _getViewPerState(state)),
        _renderButton(context, state)
      ]);
    }
  }

  _getViewPerState(LoginState state) {
    if (state is Unauthenticated) {
      return PhoneInput(
          phone: phone,
          prefix: prefix,
          updatePhone: updatePhone,
          updatePrefix: updatePrefix);
    } else if (state is OtpSentState ||
        state is OtpExceptionState ||
        state is OtpResentState) {
      SystemChannels.textInput.invokeMethod('TextInput.show');
      return PinInput(otp: otp, updateOtp: updateOtp, resendPin: _resendOTP);
    } else if (state is LoginCompleteState) {
      return Container();
    } else if (state is LoadingVerificationState) {
      SystemChannels.textInput.invokeMethod('TextInput.show');
      return PinInput(otp: otp, updateOtp: updateOtp, resendPin: _resendOTP);
    } else {
      return PhoneInput(
          phone: phone,
          prefix: prefix,
          updatePhone: updatePhone,
          updatePrefix: updatePrefix);
    }
  }

  Widget _renderButton(BuildContext context, LoginState state) {
    if (state is LoadingState) {
      return Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: Center(child: CircularProgressIndicator()));
    } else {
      return Padding(
          padding: EdgeInsets.only(bottom: 80),
          child: MaterialButton(
            onPressed: (state is OtpSentState || state is OtpExceptionState)
                ? () => _submitOtp(context)
                : () => _submitPhone(context),
            child: Text('Get started ->'),
          ));
    }
  }

  void _submitPhone(BuildContext context) {
    BlocProvider.of<LoginBloc>(context)
        .add(SendOtpEvent(prefix: prefix ?? '', phoneNumber: '$prefix$phone'));
  }

  void _submitOtp(BuildContext context) {
    //  final pin = otp.join().replaceAll(' ', '');
    final pin = otp.replaceAll(' ', '');
    BlocProvider.of<LoginBloc>(context).add(VerifyOtpEvent(otp: pin));
  }

  void _resendOTP(BuildContext context) {
    BlocProvider.of<LoginBloc>(context).add(
        ResendOtpEvent(prefix: prefix ?? '', phoneNumber: '$prefix$phone'));
  }

  void updatePhone(String? newPhone) {
    setState(() {
      phone = newPhone;
    });
  }

  void updatePrefix(String? newPrefix) {
    setState(() {
      prefix = newPrefix;
    });
  }

  void updateOtp(String? value) {
    setState(() {
      otp = value ?? '';
    });
  }
}
