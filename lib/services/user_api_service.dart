import 'dart:convert';

import 'package:euphoriafx/config/constants.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:euphoriafx/models/user_post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class UserApiService {
  final storage = FlutterSecureStorage();
  var jsonOnlyHeader = {"Accepts": "application/json"};

//Fetch a list of post from the server
  Future<List<UserPostModel>> getUsersPost() async {
    final response = await http.get(Constants.baseUrl + "users");

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<UserPostModel> users = body
          .map(
            (dynamic item) => UserPostModel.fromJson(item),
          )
          .toList();
      // If the server did return a 200 OK response, then parse the JSON.
      return users;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }
  

  //Fetch a list of post from the server
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Constants.baseUrl + "users");

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<UserModel> users = body
          .map(
            (dynamic item) => UserModel.fromJson(item),
          )
          .toList();
      // If the server did return a 200 OK response, then parse the JSON.
      return users;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<Response> addUser(Map<String, dynamic> user) async {
    print("add user called");
    final response = await http
        .post(Constants.baseUrl + "auth/signup", body: user);

    return response;
  }

  Future<dynamic> resetPassword(Map<String, dynamic> email) async {
    final response = await http
        .post(Constants.baseUrl + "rest-auth/password/reset/", body: email);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return json.decode(response.body);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<Response> login(Map<String, dynamic> user) async {
    final response =
        await http.post(Constants.baseUrl + "auth/signin", body: user);

    if (response.statusCode == 201) {

      return response;
    }
    return null;
  }

  //Fetch a single post
  Future<UserModel> getUser(int id) async {
    final response = await http.get(Constants.baseUrl + "users/" + id.toString(),
        headers: jsonOnlyHeader);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return UserModel.fromJson(json.decode(response.body)["data"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<UserModel> deletePost(UserModel postModel) {}

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );
}
