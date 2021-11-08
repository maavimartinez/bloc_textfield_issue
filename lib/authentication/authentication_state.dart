import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  final User? user;

  AuthenticationState(this.user);

  User? getUser() {
    return user;
  }

  @override
  List<Object?> get props => [user];
}

class InitialAuthenticationState extends AuthenticationState {
  InitialAuthenticationState(User? user) : super(user);
}

class Uninitialized extends AuthenticationState {
  Uninitialized(User? user) : super(user);
}

class Authenticated extends AuthenticationState {
  Authenticated(User? user) : super(user);
}

class UserNotCreated extends AuthenticationState {
  UserNotCreated(User? user) : super(user);
}

class Unauthenticated extends AuthenticationState {
  Unauthenticated(User? user) : super(user);
}

class Loading extends AuthenticationState {
  Loading(User? user) : super(user);
}
