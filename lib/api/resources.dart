import 'dart:convert';

import 'package:betterself_flutter/api/api.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

getAccessToken() async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'accessToken';
  var token = prefs.getString(key) ?? "";
  return token;
}

postLogin(String username, String password) async {
  final http.Response response = await http.post(
    loginEndpoint,
    headers: unAuthenticatedAPIHeaders,
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  return response;
}

getSupplements() async {
  final token = await getAccessToken();
  final supplementURL = getResourceEndpoint("supplements");
  final headers = getAuthorizedHeaders(token);

  final http.Response response = await http.get(
    supplementURL,
    headers: headers,
  );

  final supplements = supplementFromJson(response.body);
  return supplements;

}