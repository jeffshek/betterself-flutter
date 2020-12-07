import 'dart:convert';
import 'dart:developer';

import 'package:betterself_flutter/api/api.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/models/LoginResponse.dart';
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
    body: jsonEncode(
      <String, String>{
        'username': username,
        'password': password,
      },
    ),
  );
  return response;
}

postCreateUser(String username, String password1, String password2, String email) async {
  var postDetails = <String, String>{
    'username': username,
    // an issue where you're supporting betterself and writeup signup methods
    'password': password1,
    'password1': password1,
    'password2': password2,
    'signed_up_from': 'betterself-mobile',
  };

  if (email != "") {
    postDetails['email'] = email;
  }

  final http.Response response = await http.post(
    registerEndpoint,
    headers: unAuthenticatedAPIHeaders,
    body: jsonEncode(postDetails),
  );

  return response;
}

getSupplements() async {
  final token = await getAccessToken();
  final supplementURL = getResourceEndpoint(BACKEND_SUPPLEMENTS_RESOURCE);
  final headers = getAuthorizedHeaders(token);

  log (supplementURL);

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

  final resourceURL = getResourceEndpoint(BACKEND_SUPPLEMENTS_LOGS_RESOURCE);

  final resourceURLWithLimit = resourceURL + "?limit=$limit";

  final http.Response response = await http.get(
    resourceURLWithLimit,
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

deleteSupplementLog(SupplementLog instance, [BuildContext context]) async {
  final token = await getAccessToken();
  final headers = getAuthorizedHeaders(token);
  final instanceEditURL = getSupplementLogInstanceURL(instance);

  final http.Response response = await http.delete(
    instanceEditURL,
    headers: headers,
  );

  if ([200, 204].contains(response.statusCode)) {
    if (context != null) {
      const deleteMessage = "Log Has Been Deleted";
      getSuccessSnackbarNotification(context, deleteMessage);
    }
  }

  // final parsed = jsonDecode(response.body);
  // return parsed;
}

createUser(String username, String password1, String password2, String email, [BuildContext context]) async {
  final http.Response response = await postCreateUser(username, password1, password2, email);

  if ([200, 201].contains(response.statusCode)) {
    var loginResponse = loginResponseFromJson(response.body);
    var token = loginResponse.key;
    saveAccessToken(token);

    Navigator.pushNamed(
      context,
      RouteConstants.SUPPLEMENT_LIST_ROUTE,
    );

    final message = "$username has been created!";
    getSuccessSnackbarNotification(context, message);
  }
  else {
    if (context != null) {
      getErrorSnackbarNotification(response.body, context);
    }
  }

  return response;
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
