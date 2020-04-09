import 'package:flutter/cupertino.dart';

class PackageModel {
  int id;

  String title;

  String description;

  DateTime createdAt;

  DateTime updatedAt;

  PackageModel(
      {this.id,
      @required this.title,
      @required this.description,
      this.createdAt,
      this.updatedAt});

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map toMap(){
    var map = new Map<String, dynamic>();
      map["id"] = id;
      map["title"] = title;
      map["created_at"] = createdAt;
      map["updated_at"] = updatedAt;

      return map;
  }  
}
