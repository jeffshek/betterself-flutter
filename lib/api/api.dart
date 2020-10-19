const String serverAPI  = "https://open.senrigan.io";
const Map<String, String> unAuthenticatedAPIHeaders = {
'Content-Type': 'application/json; charset=UTF-8',
};
const String loginEndpoint =  "$serverAPI/rest-auth/login/";

String getResourceEndpoint (String resource) {
  return "$serverAPI/$resource/";
}