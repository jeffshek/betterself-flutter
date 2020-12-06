const String serverAPI  = "https://open.senrigan.io/";
const String apiBetterSelfV2 = "api/betterself/v2/";

const String BACKEND_SUPPLEMENTS_RESOURCE = "supplements/";
const String BACKEND_SUPPLEMENTS_LOGS_RESOURCE = "supplement_logs/";

const String LOGIN_RESOURCE_NAME =  'rest-auth/login/';
const String REGISTRATION_RESOURCE_NAME =  'rest-auth/registration/';

const String betterSelfServerAPI = "$serverAPI$apiBetterSelfV2";

const Map<String, String> unAuthenticatedAPIHeaders = {
  'Content-Type': 'application/json; charset=UTF-8',
};

const String loginEndpoint =  "$serverAPI$LOGIN_RESOURCE_NAME";
const String registerEndpoint = "$serverAPI$REGISTRATION_RESOURCE_NAME";