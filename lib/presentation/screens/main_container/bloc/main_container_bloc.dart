import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_event.dart';
import 'package:bloc_textfield_issue/authentication/authentication_state.dart';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';
import 'bloc.dart';

class MainContainerBloc extends Bloc<MainContainerEvent, MainContainerState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  String verID = "";

  MainContainerBloc(
      {required UserRepository userRepository,
      required AuthenticationBloc authenticationBloc})
      : _userRepository = userRepository,
        _authenticationBloc = authenticationBloc,
        super(InitialMainContainerState(user: authenticationBloc.state.user));

  MainContainerState get initialState =>
      InitialMainContainerState(user: _authenticationBloc.state.user);

  @override
  Stream<MainContainerState> mapEventToState(
    MainContainerEvent event,
  ) async* {
    _authenticationBloc.stream.listen(((authState) {
      if (authState is Loading) {
        add(UserEditedInAuthenticationBlocEvent(
            user: authState.user ?? User(uid: '', phone: '')));
      }
    }));
    if (event is LogoutEvent) {
      _authenticationBloc.add(LoggedOut());
    } else if (event is UserEditedInAuthenticationBlocEvent) {
      if (event.user!.uid != '') {
        yield WorkoutsFetchedState(user: event.user);
      } else {
        yield LoggedOutState(user: null);
      }
    }
  }

  @override
  void onEvent(MainContainerEvent event) {
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
