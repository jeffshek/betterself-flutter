import 'dart:async';
import 'dart:developer';

import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/RouteHeadingTextPadding.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/models/LoginResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LogoutScreen extends StatefulWidget {
  @override
  _LogoutScreenState createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  @override
  void initState() {
    _clearAccessToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                          SizedBox(height: 25),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
      ),
    );
  }

  _clearAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    log("Logged Out");

    Navigator.pushNamed(context, RouteConstants.LOGIN_FORM_ROUTE);
  }
}
