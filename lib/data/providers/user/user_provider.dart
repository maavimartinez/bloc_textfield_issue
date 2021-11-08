import 'dart:io';

import 'package:bloc_textfield_issue/data/models/user.dart';

abstract class UserApiProvider {
  const UserApiProvider();

  Future<User> verifyAndLogin(
      {required String verificationId, required String otp});

  Future<User?> fetchUser({required String uid});

  Future<User?> fetchLoggedUser();

  Future<void> logout();

  Future<User?> createAccount(
      {required String email,
      required String username,
      required File? avatar,
      required String fullName});

  Future<User> updateAccount({required User user, required File? avatar});

  Stream<dynamic> sendOTP(
      {required String phone,
      required Duration timeout,
      required bool isResendCodeEvent});
}
