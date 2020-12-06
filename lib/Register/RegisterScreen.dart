import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/RouteHeadingTextPadding.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:http/http.dart' as http;


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

const FORM_MARGIN_PAD = 25.0;

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<http.Response> createUser(String username, String password) async {
    // final http.Response response = await postLogin(username, password);
    //
    // if (response.statusCode == 200) {
    //   var loginResponse = loginResponseFromJson(response.body);
    //   var token = loginResponse.key;
    //   _saveAccessToken(token);
    //
    //   Navigator.pushNamed(
    //     context,
    //     RouteConstants.SUPPLEMENT_LIST_ROUTE,
    //   );
    // }
    //
    // return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            'username': "",
            "password": "",
            "verifyPassword": "",
            "email": "",
          },
          child: Column(
            children: <Widget>[
              getSafeAreaDefault(context),
              getRouteBetterSelfHeaderTextPadding("Register"),
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
                          SizedBox(height: FORM_MARGIN_PAD),
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
                          SizedBox(height: FORM_MARGIN_PAD),
                          FormBuilderTextField(
                            attribute: "password",
                            decoration: InputDecoration(labelText: "Confirm Password"),
                            obscureText: true,
                            maxLines: 1,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(4),
                              FormBuilderValidators.maxLength(32)
                            ],
                          ),
                          SizedBox(height: FORM_MARGIN_PAD),
                          FormBuilderTextField(
                            attribute: "email",
                            decoration: InputDecoration(labelText: "Email Address (Optional)"),
                            obscureText: false,
                            maxLines: 1,
                            validators: [
                              // FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(4),
                              FormBuilderValidators.maxLength(32)
                            ],
                          ),
                          SizedBox(height: FORM_MARGIN_PAD * 2),
                          WideAppButton(
                            textContent: "Create Account",
                            onPressed: () {
                              _fbKey.currentState.save();
                              if (_fbKey.currentState.validate()) {
                                print(_fbKey.currentState.value);
                                // login(_fbKey.currentState.value['username'],
                                //     _fbKey.currentState.value['password']);
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
}
