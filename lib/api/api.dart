import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

Map<String, String> getAuthorizedHeaders (String token) {
  Map<String, String> authorizedHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Token $token'
  };

  return authorizedHeaders;
}

String getResourceEndpoint (String resource) {
  var resourceSerialized = resource;

  if (resourceSerialized[0] == "/") {
    resourceSerialized = resourceSerialized.substring(1);
  }

  // get last item of a string to see if it ends with a '/'
  if (resourceSerialized.substring(resourceSerialized.length - 1 ) != "/") {
    resourceSerialized = "$resourceSerialized/";
  }

  return "$betterSelfServerAPI$resourceSerialized";
}

saveAccessToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  final key = 'accessToken';
  prefs.setString(key, token);
}