import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/RouteHeadingTextPadding.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

const FORM_MARGIN_PAD = 25.0;

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          // how it's stored on the backend, keep the same for easier compat
          initialValue: {
            'username': "dummy-account2",
            "password1": "dummy-account",
            "password2": "dummy-account",
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
                            attribute: "password1",
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
                            attribute: "password2",
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
                              // FormBuilderValidators.minLength(4),
                              FormBuilderValidators.maxLength(32)
                            ],
                          ),
                          SizedBox(height: FORM_MARGIN_PAD * 2),
                          WideAppButton(
                            textContent: "Create Account",
                            onPressed: () {
                              _fbKey.currentState.save();
                              if (_fbKey.currentState.validate()) {
                                createUser(
                                    _fbKey.currentState.value['username'],
                                    _fbKey.currentState.value['password1'],
                                    _fbKey.currentState.value['password2'],
                                    _fbKey.currentState.value['email'],
                                    context
                                );
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
