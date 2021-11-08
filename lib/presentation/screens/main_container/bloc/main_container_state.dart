import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainContainerState extends Equatable {
  final User? user;
  const MainContainerState({required this.user});
  @override
  List<Object?> get props => [user];
}

class LoggedOutState extends MainContainerState {
  final User? user;
  const LoggedOutState({required this.user}) : super(user: null);
  @override
  List<Object?> get props => [user];
}

class InitialMainContainerState extends MainContainerState {
  final User? user;
  const InitialMainContainerState({required this.user}) : super(user: null);
}

class WorkoutsLoadingState extends MainContainerState {
  final User? user;
  const WorkoutsLoadingState({required this.user}) : super(user: null);
}

class WorkoutUpdateLoadingState extends MainContainerState {
  final User? user;
  const WorkoutUpdateLoadingState({required this.user}) : super(user: null);
}

class WorkoutsFetchedState extends MainContainerState {
  final User? user;
  const WorkoutsFetchedState({required this.user}) : super(user: null);
}

class WorkoutUpdatedState extends MainContainerState {
  final User? user;
  const WorkoutUpdatedState({required this.user}) : super(user: null);
}

class ExceptionState extends MainContainerState {
  final String message;
  final User? user;

  ExceptionState({required this.message, required this.user})
      : super(user: null);

  @override
  List<Object?> get props => [message, user];
}
