import 'package:flutter/cupertino.dart';

class ImageModel {
  int imageId;

  String path;

  DateTime createdAt;

  DateTime updatedAt;

  ImageModel({this.imageId, @required this.path, this.createdAt, this.updatedAt});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      imageId: json["id"],
      path: json["path"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"])
    );
  }
}
