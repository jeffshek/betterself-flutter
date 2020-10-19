// To parse this JSON data, do
//
//     final supplements = supplementsFromJson(jsonString);

import 'dart:convert';

List<Supplements> supplementsFromJson(String str) => List<Supplements>.from(json.decode(str).map((x) => Supplements.fromJson(x)));

String supplementsToJson(List<Supplements> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supplements {
  Supplements({
    this.uuid,
    this.created,
    this.modified,
    this.name,
    this.notes,
    this.ingredientCompositions,
    this.displayName,
    this.isTakenWithFood,
  });

  String uuid;
  DateTime created;
  DateTime modified;
  String name;
  String notes;
  List<dynamic> ingredientCompositions;
  String displayName;
  dynamic isTakenWithFood;

  factory Supplements.fromJson(Map<String, dynamic> json) => Supplements(
    uuid: json["uuid"],
    created: DateTime.parse(json["created"]),
    modified: DateTime.parse(json["modified"]),
    name: json["name"],
    notes: json["notes"],
    ingredientCompositions: List<dynamic>.from(json["ingredient_compositions"].map((x) => x)),
    displayName: json["display_name"],
    isTakenWithFood: json["is_taken_with_food"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "created": created.toIso8601String(),
    "modified": modified.toIso8601String(),
    "name": name,
    "notes": notes,
    "ingredient_compositions": List<dynamic>.from(ingredientCompositions.map((x) => x)),
    "display_name": displayName,
    "is_taken_with_food": isTakenWithFood,
  };
}
