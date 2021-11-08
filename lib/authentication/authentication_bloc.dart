import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';

import 'authentication_state.dart';
import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc(this._userRepository) : super(Uninitialized(null));

  @override
  // ignore: override_on_non_overriding_member
  AuthenticationState get initialState => InitialAuthenticationState(null);

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final User? user = await _userRepository.fetchLoggedUser();

      if (user != null) {
        yield Authenticated(user);
      } else {
        yield Unauthenticated(null);
      }
    }

    if (event is LoggedIn) {
      yield Loading(event.user);
      yield Authenticated(event.user);
    }

    if (event is LoggedOut) {
      yield Loading(null);
      yield Unauthenticated(null);
      _userRepository.logout();
    }
  }
}
