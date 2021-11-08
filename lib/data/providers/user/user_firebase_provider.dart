import 'dart:async';
import 'dart:io';
import 'package:bloc_textfield_issue/data/models/user.dart';
import 'package:bloc_textfield_issue/data/providers/user/user_provider.dart';
import 'package:equatable/equatable.dart';

class FirebaseUserApiProvider extends Equatable implements UserApiProvider {
  const FirebaseUserApiProvider();

  Future<User> verifyAndLogin(
      {required String verificationId, required String otp}) async {
    return User(
        uid: '43453453445345345',
        phone: '+59899751737',
        fullName: 'Maria Victoria Martinez',
        username: 'maavimartinez');
  }

  @override
  Future<User?> fetchUser({required String uid}) async {
    return User(
        uid: '43453453445345345',
        phone: '+59899751737',
        fullName: 'Maria Victoria Martinez',
        username: 'maavimartinez');
  }

  @override
  Future<User?> createAccount(
      {required String email,
      required String username,
      required File? avatar,
      required String fullName}) async {
    return User(
        uid: '43453453445345345',
        phone: '+59899751737',
        fullName: 'Maria Victoria Martinez',
        username: 'maavimartinez');
  }

  @override
  Future<User> updateAccount(
      {required User user, required File? avatar}) async {
    return User(
        uid: '43453453445345345',
        phone: '+59899751737',
        fullName: 'Maria Victoria Martinez',
        username: 'maavimartinez');
  }

  @override
  Stream<dynamic> sendOTP(
      {required String phone,
      required Duration timeout,
      required bool isResendCodeEvent}) async* {
    StreamController<dynamic> eventStream = StreamController();
    final user = User(
        uid: '43453453445345345',
        phone: '+59899751737',
        fullName: 'Maria Victoria Martinez',
        username: 'maavimartinez');
    eventStream.add({'status': 'phoneVerificationCompleted', 'uid': user.uid});
    eventStream.close();

    yield* eventStream.stream;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<User?> fetchLoggedUser() async {
    return User(
        uid: '43453453445345345',
        phone: '+59899751737',
        fullName: 'Maria Victoria Martinez',
        username: 'maavimartinez');
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
