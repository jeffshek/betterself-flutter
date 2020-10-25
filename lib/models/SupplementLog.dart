// To parse this JSON data, do
//
//     final supplementLog = supplementLogFromJson(jsonString);

import 'dart:convert';
import 'Supplement.dart';

List<SupplementLog> supplementLogFromJson(String str) => List<SupplementLog>.from(json.decode(str).map((x) => SupplementLog.fromJson(x)));

String supplementLogToJson(List<SupplementLog> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SupplementLog {
  SupplementLog({
    this.displayName,
    this.uuid,
    this.notes,
    this.supplement,
    this.source,
    this.quantity,
    this.time,
    this.durationMinutes,
  });

  String displayName;
  String uuid;
  String notes;
  Supplement supplement;
  String source;
  String quantity;
  DateTime time;
  dynamic durationMinutes;

  factory SupplementLog.fromJson(Map<String, dynamic> json) => SupplementLog(
    displayName: json["display_name"],
    uuid: json["uuid"],
    notes: json["notes"],
    supplement: Supplement.fromJson(json["supplement"]),
    source: json["source"],
    quantity: json["quantity"],
    time: DateTime.parse(json["time"]),
    durationMinutes: json["duration_minutes"],
  );

  Map<String, dynamic> toJson() => {
    "display_name": displayName,
    "uuid": uuid,
    "notes": notes,
    "supplement": supplement.toJson(),
    "source": source,
    "quantity": quantity,
    "time": time.toIso8601String(),
    "duration_minutes": durationMinutes,
  };
}

