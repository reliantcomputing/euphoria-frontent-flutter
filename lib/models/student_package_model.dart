
import 'package:flutter/material.dart';

class StudentPackageModel {
  int id;
  int studentId;
  int packageId;
  DateTime createdAt;
  DateTime updatedAt;

  StudentPackageModel(
      {this.id,
      @required this.packageId,
      @required this.studentId,
      this.createdAt,
      this.updatedAt});
      
  factory StudentPackageModel.fromJson(Map<String, dynamic> json) {
    return StudentPackageModel(
      id: json['id'],
      studentId: json['student_id'],
      packageId: json['package_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
