import 'dart:async';
import 'dart:convert';

import 'package:betterself_flutter/api.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:betterself_flutter/models/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormScreen extends StatefulWidget {
  @override
  _LoginFormScreenState createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
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
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
                child: Column(
                  children: <Widget>[
                    SafeArea(
                      child: Container(
                        padding: EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 25, right: 25, top: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          headerText("BetterSelf"),
                          SizedBox(width: 4),
                          Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: subheaderText("Login"))
                        ],
                      ),
                    ),
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
                          AppButton(
                            textContent: "Login",
                            onPressed: () {
                              _fbKey.currentState.save();
                              if (_fbKey.currentState.validate()) {
                                print(_fbKey.currentState.value);
                                login(_fbKey.currentState.value['username'],
                                    _fbKey.currentState.value['password']);
                              }
                            },
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

  Future<http.Response> login(String username, String password) async {
    final http.Response response = await http.post(
      loginEndpoint,
      headers: unAuthenticatedAPIHeaders,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var loginResponse = loginResponseFromJson(response.body);
      print(loginResponse.toJson());
      var token = loginResponse.key;
      _saveAccessToken(token);
    }

    return response;
  }

  _saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'accessToken';
    prefs.setString(key, token);
    print ('Saved Token');
  }

  _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'accessToken';
    var token = prefs.getString(key) ?? "";
    print ("Saved Token is $token");
  }
}
