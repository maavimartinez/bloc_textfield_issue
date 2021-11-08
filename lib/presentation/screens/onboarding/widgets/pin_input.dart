import 'package:bloc_textfield_issue/presentation/screens/onboarding/bloc/bloc.dart';
import 'package:bloc_textfield_issue/presentation/utils/custom_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinInput extends StatefulWidget {
  final String? otp;
  final Function updateOtp;
  final Function resendPin;
  const PinInput(
      {required this.otp, required this.updateOtp, required this.resendPin});
  @override
  _PinInputState createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  String? error;
  FocusNode focus = FocusNode();

  @override
  void initState() {
    focus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState is OtpExceptionState) {
            if (loginState.message.contains('Invalid otp!')) {
              setState(() {
                error = 'The pin you enter is invalid';
              });
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _renderTitle(),
            Container(height: 20),
            _renderSubtitle(),
            Container(height: 50),
            Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: _pinTextField()),
            Container(height: 30),
            if (error != null)
              Text(error ?? '', style: Theme.of(context).textTheme.caption)
          ],
        ));
  }

  Widget _pinTextField() {
    final hintStyle =
        TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w500);
    final style =
        TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w500);
    return Container(
        margin: EdgeInsets.only(right: 0.0),
        child: TextField(
            autofocus: true,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 6,
            style: style,
            focusNode: focus,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.white,
                hintText: '123456',
                hintStyle: hintStyle,
                focusColor: Colors.white,
                hoverColor: Colors.white,
                counterText: "",
                filled: false),
            onChanged: (String str) {
              setState(() {
                widget.updateOtp(str);
              });
            }));
  }

  Widget _renderTitle() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: FittedBox(
              child: Text('Enter the pin you received',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!)));
    } else {
      return Container(
          height: MediaQuery.of(context).size.height * 0.06,
          child: FittedBox(
              child: Text('Enter the pin you received',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!)));
    }
  }

  Widget _renderSubtitle() {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: FittedBox(child: _renderText()));
    } else {
      return Container(
          height: MediaQuery.of(context).size.height * 0.05,
          width: MediaQuery.of(context).size.width * 0.7,
          child: FittedBox(child: _renderText()));
    }
  }

  Widget _renderText() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Didn't receive it?",
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(fontSize: MediaQuery.of(context).size.height * 0.03)),
      Container(width: 5),
    ]);
  }

  void setOtp(var i, String value) {
    setState(() {
      error = null;
    });
    widget.updateOtp(i, value);
  }
}
