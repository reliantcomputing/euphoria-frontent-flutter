import 'package:flutter/cupertino.dart';

class StudentModel{

  int id;

  String firstName;

  String lastName;

  String email;

  String phoneNumber;

  DateTime createdAt;

  DateTime updatedAt;

  StudentModel({
    this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.phoneNumber,
    this.createdAt,
    this.updatedAt
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}