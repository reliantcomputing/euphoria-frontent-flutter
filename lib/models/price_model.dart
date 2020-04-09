import 'package:flutter/cupertino.dart';

class PriceModel {
  int id;

  String price;

  String currency;

  DateTime createdAt;

  DateTime updatedAt;

  int packageId;

  PriceModel(
      {this.id,
      @required this.price,
      @required this.currency,
      this.createdAt,
      this.updatedAt,
      @required this.packageId});

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      id: json['id'],
      price: json['price'],
      currency: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      packageId: json['package_id'],
    );
  }
}
