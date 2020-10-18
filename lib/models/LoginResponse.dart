// Copy and pasted from https://app.quicktype.io/

import 'dart:convert';
import 'User.dart';

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
