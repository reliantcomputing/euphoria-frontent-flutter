import 'package:flutter/cupertino.dart';

class AuthUser {
  String username;

  String email;

  String password1;

  String password2;

  AuthUser({
    @required this.username,
    @required this.email,
    @required this.password1,
    @required this.password2,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      username: json["username"],
      email: json["email"],
      password1: json["password1"],
      password2: json["password2"],
    );
  }
}
