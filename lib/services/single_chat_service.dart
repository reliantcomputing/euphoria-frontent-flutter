import 'dart:convert';

import 'package:euphoriafx/config/constants.dart';
import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/single_chat_model.dart';
import 'package:euphoriafx/models/user_model.dart';
import 'package:euphoriafx/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SingleChatService {
  var url = Constants.baseUrl + "chats/";

  var authService = s1<AuthService>();

  //Fetch a list of post from the server
  Future<List<SingleChatModel>> getSingleChats() async {
    final response = await http.get(url);

    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<SingleChatModel> messages = body
          .map(
            (dynamic item) => SingleChatModel.fromJson(item),
          )
          .toList();
      // If the server did return a 200 OK response, then parse the JSON.
      return messages;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  //Fetch a single post
  Future<SingleChatModel> getSingleChat(int id) async {
    final response = await http.get(this.url + id.toString(),
        headers: authService.httpHeaders);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return SingleChatModel.fromJson(json.decode(response.body)["data"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<http.Response> addSingleChat(Map<String, dynamic> singleChat) async {
    final response = await http.post(Constants.baseUrl + "posts/",
        body: singleChat, headers: authService.httpHeaders);
    return response;
  }

  Future<SingleChatModel> deletePost(SingleChatModel postModel) {}

  UserModel otherUser(
      {UserModel userOne, UserModel userTwo, BuildContext context}) {
    if (authService.getTokenFromStorageObj() == null) {
      authService.redirectToLogin(context);
    }
    if (authService.parseJwt(authService.getTokenFromStorageObj())["id"] !=
        userOne.userId) {
      return userOne;
    } else {
      return userTwo;
    }
  }
}
