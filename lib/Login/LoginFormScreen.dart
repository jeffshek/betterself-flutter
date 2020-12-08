import 'dart:async';

import 'package:betterself_flutter/api/api.dart';
import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/RouteHeadingTextPadding.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/models/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class LoginFormScreen extends StatefulWidget {
  @override
  _LoginFormScreenState createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // if already logged in, move them to another page instead
    _getAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            'username': "demo-testing@senrigan.io",
            "password": "demo-testing@senrigan.io"
          },
          child: Column(
            children: <Widget>[
              getSafeAreaDefault(context),
              getRouteBetterSelfHeaderTextPadding("Login"),
              Padding(
                padding: getDefaultPaddingInsets(),
                child: Column(
                  children: <Widget>[
                    getDefaultPadding(),
                    Padding(
                      padding: EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "username",
                            decoration: InputDecoration(labelText: "User Name"),
                          ),
                          SizedBox(height: 25),
                          FormBuilderTextField(
                            attribute: "password",
                            decoration: InputDecoration(labelText: "Password"),
                            obscureText: true,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(4),
                              FormBuilderValidators.maxLength(32)
                            ],
                          ),
                          SizedBox(height: 18),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              NarrowButton(
                                textContent: "Register",
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    RouteConstants.REGISTER_ROUTE,
                                  );
                                },
                              ),
                              NarrowButton(
                                textContent: "Login",
                                onPressed: () {
                                  _fbKey.currentState.save();
                                  if (_fbKey.currentState.validate()) {
                                    // print(_fbKey.currentState.value);
                                    login(_fbKey.currentState.value['username'],
                                        _fbKey.currentState.value['password'],
                                    context);
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> login(String username, String password, [BuildContext context]) async {
    final http.Response response = await postLogin(username, password);

    if (response.statusCode == 200) {
      var loginResponse = loginResponseFromJson(response.body);
      var token = loginResponse.key;
      saveAccessToken(token);

      Navigator.pushNamed(
        context,
        RouteConstants.SUPPLEMENT_LIST_ROUTE,
      );

      const message = "Login Successful";
      getSuccessSnackbarNotification(context, message);
    }
    else {
      if (context != null) {
        getErrorSnackbarNotification(response.body, context);
      }
    }

    return response;
  }

  // _saveAccessToken(String token) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'accessToken';
  //   prefs.setString(key, token);
  // }

  _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'accessToken';
    var token = prefs.getString(key) ?? "";

    if (token != "") {
      Navigator.pushNamed(
        context,
        RouteConstants.SUPPLEMENT_LOG_LIST_ROUTE,
      );

      // var isProd = isProduction.toString();
      // var message = "Detected Session: Is Production $isProd";
      const message = "User Sessions Detected, Logging In!";

      getSuccessSnackbarNotification(context, message);
    }
  }
}
