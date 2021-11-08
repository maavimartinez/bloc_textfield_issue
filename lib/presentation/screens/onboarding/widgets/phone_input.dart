import 'package:bloc_textfield_issue/presentation/screens/onboarding/bloc/bloc.dart';
import 'package:bloc_textfield_issue/presentation/screens/onboarding/widgets/phone_custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhoneInput extends StatefulWidget {
  final String? phone;
  final Function updatePhone;
  final String? prefix;
  final Function updatePrefix;
  PhoneInput(
      {required this.phone,
      required this.prefix,
      required this.updatePhone,
      required this.updatePrefix});
  @override
  _PhoneInputState createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  String? error;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState is ExceptionState) {
            if (loginState.message.contains(
                'The format of the phone number provided is incorrect')) {
              setState(() {
                error = 'Please enter a valid phone number.';
              });
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _renderTitle(),
            Container(height: 30),
            _renderSubtitle(),
            Container(height: 30),
            _renderInput(),
            Container(height: 30),
            if (error != null)
              Text(error ?? '',
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.03))
          ],
        ));
  }

  Widget _renderTitle() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: FittedBox(
              child: Text('Welcome to Hoopfit!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!)));
    } else {
      return Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: FittedBox(
              child: Text('Welcome to Hoopfit!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!)));
    }
  }

  Widget _renderSubtitle() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Text(
              'Please enter your phone to sign up or login to your account. \n You will receive a message with a validation pin.',
              textAlign: TextAlign.center,
              maxLines: 3,
              style: Theme.of(context).textTheme.bodyText1!));
    } else {
      return Container(
          height: MediaQuery.of(context).size.height * 0.075,
          width: MediaQuery.of(context).size.width * 0.7,
          child: FittedBox(
              child: Text(
                  'Please enter your phone to sign up or login to your account.\nYou will receive a message with a validation pin.',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText1!)));
    }
  }

  Widget _renderInput() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.91,
          padding: EdgeInsets.only(left: 10, top: 4, bottom: 4),
          child: Row(children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: PhoneCustomInput(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.6),
                  fieldHeight: 40,
                  fontSize: 15,
                  phoneNumber: widget.phone,
                  refreshParent: widget.updatePhone,
                ))
          ]));
    } else {
      final fontSize = MediaQuery.of(context).size.height * 0.03;
      return Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.height * 0.1 - 4,
          padding: EdgeInsets.only(left: 10, top: 4, bottom: 4),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: PhoneCustomInput(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.3),
                  fieldHeight: 40,
                  fontSize: 15,
                  phoneNumber: widget.phone,
                  refreshParent: widget.updatePhone,
                ))
          ]));
    }
  }
}
