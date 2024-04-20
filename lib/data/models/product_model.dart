import 'package:qr_code_project/data/models/product_constants.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String qrCode;
  final String dateTime;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.qrCode,
    required this.dateTime,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json[ProductModelConstants.id],
      name: json[ProductModelConstants.name],
      description: json[ProductModelConstants.description],
      qrCode: json[ProductModelConstants.qrCode],
      dateTime: json[ProductModelConstants.dateTime],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      ProductModelConstants.id: id,
      ProductModelConstants.name: name,
      ProductModelConstants.description: description,
      ProductModelConstants.qrCode: qrCode,
      ProductModelConstants.dateTime: dateTime,
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? description,
    String? qrCode,
    String? dateTime,
  }) =>
      ProductModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        qrCode: qrCode ?? this.qrCode,
        dateTime: dateTime ?? this.dateTime,
      );
}
