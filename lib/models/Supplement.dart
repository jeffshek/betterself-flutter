// To parse this JSON data, do
//
//     final supplement = supplementFromJson(jsonString);

import 'dart:convert';

List<Supplement> supplementFromJson(String str) => List<Supplement>.from(json.decode(str).map((x) => Supplement.fromJson(x)));

String supplementToJson(List<Supplement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supplement {
  Supplement({
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

  factory Supplement.fromJson(Map<String, dynamic> json) => Supplement(
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
