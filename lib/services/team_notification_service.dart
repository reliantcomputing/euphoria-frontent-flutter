//Fetch a list of post from the server
import 'dart:convert';
import 'package:euphoriafx/config/constants.dart';
import 'package:http/http.dart' as http;

import 'package:euphoriafx/models/notification_model.dart';

class TeamNotificationService {

  var url = Constants.baseUrl + "team/notifications/";

  Future<List<NotificationModel>> getTeamNotifications() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<NotificationModel> posts = body
          .map(
            (dynamic item) => NotificationModel.fromJson(item),
          )
          .toList();
      // If the server did return a 200 OK response, then parse the JSON.
      return posts;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

        //Fetch a single post
  Future<NotificationModel> getTeamNotification(int id) async {
    final response = await http.get(this.url + id.toString());

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return NotificationModel.fromJson(json.decode(response.body)["data"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }
}
