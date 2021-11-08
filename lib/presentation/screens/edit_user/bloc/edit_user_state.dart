import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class EditUserState extends Equatable {
  final User? user;
  EditUserState({required this.user});
  @override
  List<Object?> get props => [user];
}

class InitialEditUserState extends EditUserState {
  final User user;
  InitialEditUserState({required this.user}) : super(user: null);
  @override
  List<Object?> get props => [user];
}

class LoadingState extends EditUserState {
  final User user;
  LoadingState({required this.user}) : super(user: null);
  @override
  List<Object?> get props => [user];
}

class EditCompletedState extends EditUserState {
  final User user;
  EditCompletedState({required this.user}) : super(user: null);
  @override
  List<Object?> get props => [user];
}

class ExceptionState extends EditUserState {
  final String message;

  ExceptionState({required this.message}) : super(user: null);

  @override
  List<Object?> get props => [message];
}
