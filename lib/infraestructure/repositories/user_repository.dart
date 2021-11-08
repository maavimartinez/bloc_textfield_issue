import 'dart:io';

import 'package:bloc_textfield_issue/data/providers/user/user_provider.dart';

import '../../data/models/user.dart';

class UserRepository {
  final UserApiProvider _provider;

  const UserRepository({required UserApiProvider apiProvider})
      : _provider = apiProvider;

  Stream<dynamic> sendOTP(
      {required String phone,
      required Duration timeout,
      required bool isResendCodeEvent}) {
    return _provider.sendOTP(
        phone: phone, timeout: timeout, isResendCodeEvent: isResendCodeEvent);
  }

  Future<User> verifyAndLogin(String verificationId, String otp) {
    return _provider.verifyAndLogin(verificationId: verificationId, otp: otp);
  }

  Future<User?> fetchUser(String uid) {
    return _provider.fetchUser(uid: uid);
  }

  Future<User?> fetchLoggedUser() {
    return _provider.fetchLoggedUser();
  }

  Future<User?> createAccount(
      {required String email,
      required String username,
      required File? avatar,
      required DateTime? birthdate,
      required String fullName}) {
    return _provider.createAccount(
      email: email,
      username: username,
      avatar: avatar,
      fullName: fullName,
    );
  }

  Future<User> updateAccount({required User user, required File? avatar}) {
    return _provider.updateAccount(user: user, avatar: avatar);
  }

  Future<void> logout() async {
    return await _provider.logout();
  }
}
