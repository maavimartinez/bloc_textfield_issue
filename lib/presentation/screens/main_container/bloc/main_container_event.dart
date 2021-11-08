import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';

class MainContainerEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class WorkoutFetchedEvent extends MainContainerEvent {}

class UserEditedInAuthenticationBlocEvent extends MainContainerEvent {
  final User? user;
  UserEditedInAuthenticationBlocEvent({required this.user});
}

class LogoutEvent extends MainContainerEvent {}
