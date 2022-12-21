// To parse this JSON data, do
//
//     final debtsListModel = debtsListModelFromJson(jsonString);

import 'dart:convert';

DebtsListModel debtsListModelFromJson(String str) =>
    DebtsListModel.fromJson(json.decode(str));

String debtsListModelToJson(DebtsListModel data) => json.encode(data.toJson());

class DebtsListModel {
  DebtsListModel({
    this.id,
    this.details,
    this.total,
    this.created,
  });

  String? id;
  String? details;
  int? total;
  DateTime? created;

  factory DebtsListModel.fromJson(Map<String, dynamic> json) => DebtsListModel(
        id: json["id"],
        details: json["details"],
        total: json["total"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "details": details,
        "total": total,
        "created": created?.toIso8601String(),
      };
}
