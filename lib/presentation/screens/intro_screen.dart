import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding/phone_input_and_verification_screen.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';

class IntroScreen extends StatefulWidget {
  final BuildContext context;
  IntroScreen({required this.context});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;
  bool swipeLeft = false;
  final controller = PageController();

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _renderSliderAndButton(),
          ],
        ),
      )
    ]));
  }

  Widget _renderSliderAndButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: MaterialButton(
                onPressed: _goToPhoneInput,
                color: Colors.white,
                child: Text('Get started')))
      ],
    );
  }

  void _goToPhoneInput() {
    Navigator.push(
      widget.context,
      MaterialPageRoute(
          builder: (context) => BlocProvider.value(
              value: BlocProvider.of<AuthenticationBloc>(widget.context),
              child: PhoneInputAndVerificationScreen())),
    );
  }
}
