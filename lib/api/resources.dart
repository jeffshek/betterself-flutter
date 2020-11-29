import 'dart:convert';
import 'dart:developer';

import 'package:betterself_flutter/api/api.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:betterself_flutter/models/SupplementLog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

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

getSupplementLogs({int limit = 200}) async {
  final token = await getAccessToken();
  final headers = getAuthorizedHeaders(token);

  final resourceURL = getResourceEndpoint("supplement_logs");

  final resourceURLwithLimit = resourceURL + "?limit=$limit";

  final http.Response response = await http.get(
    resourceURLwithLimit,
    headers: headers,
  );

  final supplementLogs = supplementLogFromJson(response.body);
  return supplementLogs;
}

getSupplementInstanceURL(Supplement supplement) {
  final supplementURL = getResourceEndpoint(BACKEND_SUPPLEMENTS_RESOURCE);
  final supplementEditURL = "$supplementURL${supplement.uuid}/";
  return supplementEditURL;
}

getSupplementLogInstanceURL(SupplementLog instance) {
  final resourceURL = getResourceEndpoint(BACKEND_SUPPLEMENTS_LOGS_RESOURCE);
  final instanceEditURL = "$resourceURL${instance.uuid}/";
  return instanceEditURL;
}

updateSupplement(Supplement supplement) async {
  final token = await getAccessToken();
  final headers = getAuthorizedHeaders(token);

  final supplementEditURL = getSupplementInstanceURL(supplement);

  var data = {"name": supplement.name.trim(), "notes": supplement.notes.trim()};

  var jsonData = json.encode(data);
  final http.Response response = await http.post(
    supplementEditURL,
    headers: headers,
    body: jsonData,
  );

  final parsed = jsonDecode(response.body);
  final updatedSupplement = Supplement.fromJson(parsed);

  return updatedSupplement;
}

updateSupplementLog(SupplementLog instance) async {
  final token = await getAccessToken();
  final headers = getAuthorizedHeaders(token);

  final instanceEditURL = getSupplementLogInstanceURL(instance);

  var data = {
    "time": instance.time.toString(),
    "notes": instance.notes.trim(),
    "quantity": instance.quantity
  };

  var jsonData = json.encode(data);

  final http.Response response = await http.post(
    instanceEditURL,
    headers: headers,
    body: jsonData,
  );

  // if (response.statusCode != 200) {
  //   var errorMessage = "Error When Submitting to $instanceEditURL with $jsonData";
  //
  //   print(errorMessage);
  //   log(errorMessage);
  // }

  final parsed = jsonDecode(response.body);
  final updatedInstance = SupplementLog.fromJson(parsed);

  return updatedInstance;
}

createSupplement(Supplement supplement, [BuildContext context]) async {
  final token = await getAccessToken();
  final headers = getAuthorizedHeaders(token);
  final supplementURL = getResourceEndpoint(BACKEND_SUPPLEMENTS_RESOURCE);

  var data = {"name": supplement.name.trim(), "notes": supplement.notes.trim()};
  var jsonData = json.encode(data);

  final http.Response response = await http.post(
    supplementURL,
    headers: headers,
    body: jsonData,
  );

  final parsed = jsonDecode(response.body);

  if (response.statusCode != 200) {
    if (context != null) {
      getErrorSnackbarNotification(response.body, context);
    }
  }

  final updatedSupplement = Supplement.fromJson(parsed);
  return updatedSupplement;
}

createSupplementLog(SupplementLog supplementLog, [BuildContext context]) async {
  final token = await getAccessToken();
  final headers = getAuthorizedHeaders(token);
  final url = getResourceEndpoint(BACKEND_SUPPLEMENTS_LOGS_RESOURCE);

  var data = {
    "supplement_uuid": supplementLog.supplement.uuid,
    "time": supplementLog.time.toIso8601String(),
    "notes": supplementLog.notes,
  };

  var jsonData = json.encode(data);

  final http.Response response = await http.post(
    url,
    headers: headers,
    body: jsonData,
  );

  final parsed = jsonDecode(response.body);

  if (response.statusCode != 200) {
    if (context != null) {
      getErrorSnackbarNotification(response.body, context);
    }
  }

  final createdInstance = SupplementLog.fromJson(parsed);
  return createdInstance;
}
