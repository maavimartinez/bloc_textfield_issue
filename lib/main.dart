import 'package:bloc_textfield_issue/bloc_delegate.dart';
import 'package:bloc_textfield_issue/presentation/screens/intro_screen.dart';
import 'package:bloc_textfield_issue/presentation/screens/main_container/bloc/main_container_bloc.dart';
import 'package:bloc_textfield_issue/presentation/screens/main_container/home_screen.dart';
import 'package:bloc_textfield_issue/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'authentication/authentication_bloc.dart';
import 'authentication/bloc.dart';
import 'data/providers/user/user_firebase_provider.dart';
import 'infraestructure/repositories/user_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocDelegate();
  GetIt.instance.registerSingleton<UserRepository>(
      UserRepository(apiProvider: FirebaseUserApiProvider()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) =>
                  AuthenticationBloc(GetIt.instance.get<UserRepository>())
                    ..add(AppStarted())),
          BlocProvider<MainContainerBloc>(
            create: (context) => MainContainerBloc(
              authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
              userRepository: GetIt.instance.get<UserRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Hoopfit',
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if (state is Uninitialized) {
                return SplashScreen();
              } else if (state is Unauthenticated) {
                return IntroScreen(context: context);
              } else if (state is Authenticated) {
                return HomeScreen();
              } else {
                return IntroScreen(context: context);
              }
            },
          ),
        ));
  }
}
