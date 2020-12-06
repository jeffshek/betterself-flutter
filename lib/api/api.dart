import 'dart:developer';

import 'constants.dart';

const String serverAPI  = "https://open.senrigan.io/";
const String apiBetterSelfV2 = "api/betterself/v2/";
const String betterSelfServerAPI = "$serverAPI$apiBetterSelfV2";

const Map<String, String> unAuthenticatedAPIHeaders = {
'Content-Type': 'application/json; charset=UTF-8',
};
const String loginEndpoint =  "$serverAPI$LOGIN_RESOURCE_NAME";
const String registerEndpoint = "$serverAPI$REGISTRATION_RESOURCE_NAME";

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