import 'package:euphoriafx/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class RobotNotificationModel {
  int notificationId;

  String content;

  DateTime createdAt;

  DateTime updatedAt;

  //Reciever id
  UserModel user;

  RobotNotificationModel({
    this.notificationId,
    @required this.content,
    @required this.user,
    this.createdAt,
    this.updatedAt,
  });

  factory RobotNotificationModel.fromJson(Map<String, dynamic> json) {
    return RobotNotificationModel(
        notificationId: json['id'],
        content: json['content'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        user: UserModel.fromJson(json["user"]));
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = notificationId;
    map["content"] = content;
    map["created_at"] = createdAt;
    map["updated_at"] = updatedAt;
    map["user"] = user;

    return map;
  }
}
