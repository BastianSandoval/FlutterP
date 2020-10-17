// To parse this JSON data, do
//
//     final photos = photosFromJson(jsonString);

import 'dart:convert';

List<Plan> planFromJson(String str) =>
    List<Plan>.from(json.decode(str).map((x) => Plan.fromJson(x)));

String planToJson(List<Plan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Plan {
  Plan({
    this.id,
    this.name,
    this.price,
    this.description,
    this.updated,
    this.lastDated,
    this.v,
  });

  int id;
  String name;
  String price;
  String description;
  DateTime updated;
  DateTime lastDated;
  int v;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        updated: json["createdAt"],
        lastDated: json["updatedAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "description": description,
        "createdAt": updated,
        "updatedAt": lastDated,
        "__v": v,
      };
}
