// Copy and pasted from https://app.quicktype.io/
// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.key,
    this.user,
  });

  String key;
  User user;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    key: json["key"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "user": user.toJson(),
  };
}

class User {
  User({
    this.name,
    this.uuid,
    this.signedUpFrom,
    this.dateJoined,
    this.username,
    this.email,
    this.created,
    this.modified,
  });

  String name;
  String uuid;
  String signedUpFrom;
  DateTime dateJoined;
  String username;
  String email;
  DateTime created;
  DateTime modified;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    uuid: json["uuid"],
    signedUpFrom: json["signed_up_from"],
    dateJoined: DateTime.parse(json["date_joined"]),
    username: json["username"],
    email: json["email"],
    created: DateTime.parse(json["created"]),
    modified: DateTime.parse(json["modified"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "uuid": uuid,
    "signed_up_from": signedUpFrom,
    "date_joined": dateJoined.toIso8601String(),
    "username": username,
    "email": email,
    "created": created.toIso8601String(),
    "modified": modified.toIso8601String(),
  };
}
