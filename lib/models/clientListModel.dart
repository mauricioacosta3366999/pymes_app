import 'dart:convert';

ClientListModel clientListModelFromJson(String str) =>
    ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) =>
    json.encode(data.toJson());

class ClientListModel {
  ClientListModel({
    this.id,
    this.name,
    this.phone,
    this.pymeId,
    this.total,
  });

  String? id;
  String? name;
  String? phone;
  String? pymeId;
  int? total;

  factory ClientListModel.fromJson(Map<String, dynamic> json) =>
      ClientListModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        pymeId: json["pymeId"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "pymeId": pymeId,
        "total": total,
      };
}
