import 'package:euphoriafx/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class NotificationModel {
  int notificationId;

  String notification;

  DateTime createdAt;

  DateTime updatedAt;

  //Reciever id
  int userId;

  bool isViewed;

  NotificationModel({
    this.notificationId,
    @required this.notification,
    @required this.userId,
    this.createdAt,
    this.updatedAt,
    this.isViewed
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['id'],
      notification: json['notification'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      userId: json["user_id"],
      isViewed: json["is_viewed"]
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
      map["id"] = notificationId;
      map["notification"] = notification;
      map["created_at"] = createdAt;
      map["updated_at"] = updatedAt;
      map["user_id"] = userId;

      return map;
  }
}
