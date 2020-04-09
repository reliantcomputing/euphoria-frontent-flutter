import 'dart:convert';
import 'dart:io';

import 'package:euphoriafx/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {

  String token;

  final httpHeaders = {
  };

  // Create storage
  final storage = new FlutterSecureStorage();

  getTokenFromStorageObj() async {
    token = await storage.read(key: "token");
  }

  bool isAuthenticated() {
    getTokenFromStorageObj();
    return token != null;
  }

  void redirectToLogin(BuildContext context) {
    if (!isAuthenticated()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  getId() async{
    await getTokenFromStorageObj();
    return parseJwt(token)["sub"];
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
