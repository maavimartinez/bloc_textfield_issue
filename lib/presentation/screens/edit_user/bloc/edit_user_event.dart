import 'dart:io';

import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:equatable/equatable.dart';

class EditUserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditUserSubmittedExceptionEvent extends EditUserEvent {
  final String message;
  EditUserSubmittedExceptionEvent({required this.message});
}

class EditUserSubmittedEvent extends EditUserEvent {
  final User user;
  final File? avatar;
  EditUserSubmittedEvent({required this.user, required this.avatar});
}
