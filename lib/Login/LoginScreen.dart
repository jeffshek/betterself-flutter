import 'package:flutter/material.dart';
import 'package:betterself_flutter/constants/theme_constants.dart';
import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:betterself_flutter/components/AppButton.dart';

class LoginScreen extends StatefulWidget {
  final title = "Login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = false;
  bool rememberLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              /*back icon*/
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
              /*heading*/
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
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
                    styledText("Email", fontSize: TEXT_SIZE_MEDIUM),
                    EditText(),
                    SizedBox(height: 25),
                    styledText("Password", fontSize: TEXT_SIZE_MEDIUM),
                    EditText(isPassword: true),
                    SizedBox(height: 18),
                    Row(
                      children: <Widget>[
                        Checkbox(
                          focusColor: COLOR_PRIMARY,
                          activeColor: COLOR_PRIMARY,
                          value: rememberLogin,
                          onChanged: (bool value) {
                            setState(() {
                              rememberLogin = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    AppButton(
                      textContent: "Login",
                      onPressed: () {},
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
