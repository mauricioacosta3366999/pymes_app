import 'dart:convert';

CreateDebtModel createDebtModelFromJson(String str) =>
    CreateDebtModel.fromJson(json.decode(str));

String createDebtModelToJson(CreateDebtModel data) =>
    json.encode(data.toJson());

class CreateDebtModel {
  CreateDebtModel({
    required this.createdAt,
    required this.productName,
    required this.productPrice,
  });

  DateTime createdAt;
  String productName;
  String productPrice;

  factory CreateDebtModel.fromJson(Map<String, dynamic> json) =>
      CreateDebtModel(
        createdAt: DateTime.parse(json["createdAt"]),
        productName: json["productName"],
        productPrice: json["productPrice"],
      );

  Map<String, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "productName": productName,
        "productPrice": productPrice,
      };
}
