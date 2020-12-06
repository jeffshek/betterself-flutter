import 'constants.dart';

const String serverAPI  = "https://open.senrigan.io";
const String betterSelfServerAPI = "$serverAPI/api/betterself/v2";

const Map<String, String> unAuthenticatedAPIHeaders = {
'Content-Type': 'application/json; charset=UTF-8',
};
const String loginEndpoint =  "$serverAPI/rest-auth/login/";
const String registerEndpoint = "$serverAPI/$REGISTRATION_RESOURCE_NAME";

Map<String, String> getAuthorizedHeaders (String token) {
  Map<String, String> authorizedHeaders = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Token $token'
  };

  return authorizedHeaders;
}

String getResourceEndpoint (String resource) {
  return "$betterSelfServerAPI$resource";
}