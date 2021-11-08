class User {
  final String uid;
  final String? username;
  final String? email;
  final String? fullName;
  final String? avatarUrl;
  final String phone;

  User(
      {required this.uid,
      this.username,
      required this.phone,
      this.email,
      this.fullName,
      this.avatarUrl});

  User copyWith({
    String? uid,
    String? username,
    String? phone,
    String? email,
    String? fullName,
    String? avatarUrl,
  }) =>
      User(
          uid: uid ?? this.uid,
          fullName: fullName ?? this.fullName,
          username: username ?? this.username,
          phone: phone ?? this.phone,
          email: email ?? this.email,
          avatarUrl: avatarUrl ?? this.avatarUrl);

  User.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        phone = map['phone'],
        username = map['username'],
        email = map['email'],
        fullName = map['full_name'],
        avatarUrl = map['avatar_url'];

  Map<String, dynamic> userToMap(User user) {
    final ret = <String, dynamic>{};
    ret['uid'] = user.uid;
    ret['username'] = user.username;
    ret['phone'] = user.phone;
    ret['email'] = user.email;
    ret['avatar_url'] = user.avatarUrl;
    ret['full_name'] = user.fullName;
    return ret;
  }

  @override
  @override
  List<Object?> get props => [uid, username, phone, email, fullName, avatarUrl];
}
