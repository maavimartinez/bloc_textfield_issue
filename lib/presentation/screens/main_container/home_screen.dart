import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';
import 'package:bloc_textfield_issue/presentation/screens/main_container/profile_tab.dart';
import 'package:bloc_textfield_issue/presentation/utils/custom_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../intro_screen.dart';
import 'bloc/bloc.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocProvider<MainContainerBloc>(
            create: (context) => MainContainerBloc(
                  userRepository: GetIt.instance<UserRepository>(),
                  authenticationBloc:
                      BlocProvider.of<AuthenticationBloc>(context),
                ),
            child: BlocListener<MainContainerBloc, MainContainerState>(
                listener: (context, state) {
                  if (state is LoggedOutState) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                              value:
                                  BlocProvider.of<AuthenticationBloc>(context),
                              child: IntroScreen(context: context))),
                      (route) => false,
                    );
                  }
                },
                child: Scaffold(
                    backgroundColor: Colors.white,
                    body: IndexedStack(
                      index: _currentIndex,
                      children: [ProfileTab(context)],
                    )))));
  }
}
