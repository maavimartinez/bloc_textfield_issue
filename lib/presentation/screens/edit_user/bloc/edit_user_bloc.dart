import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_bloc.dart';
import 'package:bloc_textfield_issue/authentication/authentication_event.dart';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/infraestructure/repositories/user_repository.dart';
import 'bloc.dart';

class EditUserBloc extends Bloc<EditUserEvent, EditUserState> {
  final UserRepository _userRepository;
  final AuthenticationBloc _authenticationBloc;

  String verID = "";

  EditUserBloc(
      {required UserRepository userRepository,
      required AuthenticationBloc authenticationBloc})
      : _userRepository = userRepository,
        _authenticationBloc = authenticationBloc,
        super(InitialEditUserState(user: authenticationBloc.state.user!));

  EditUserState get initialState =>
      InitialEditUserState(user: _authenticationBloc.state.user!);

  @override
  Stream<EditUserState> mapEventToState(EditUserEvent event) async* {
    if (event is EditUserSubmittedEvent) {
      yield* updateAccount(event);
    } else if (event is EditUserSubmittedExceptionEvent) {
      yield ExceptionState(message: event.message);
    }
  }

  Stream<EditUserState> updateAccount(event) async* {
    try {
      yield LoadingState(user: event.user);
      User user = await _userRepository.updateAccount(
          user: event.user, avatar: event.avatar);
      _authenticationBloc.add(LoggedIn(user: user));
      yield EditCompletedState(user: user);
    } catch (e) {
      print(e);
      yield ExceptionState(message: "Invalid otp!");
    }
  }

  @override
  void onEvent(EditUserEvent event) {
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
