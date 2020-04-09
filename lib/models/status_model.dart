import 'package:flutter/cupertino.dart';

class StatusModel {
  int statusId;

  String status;

  DateTime updatedAt;

  int userId;

  StatusModel(
      {this.statusId,
      @required this.status,
      this.updatedAt,
      @required this.userId});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
        statusId: json["id"],
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
        userId: json["user"]);
  }
}
