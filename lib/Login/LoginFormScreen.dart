import 'package:flutter/material.dart';
import 'package:betterself_flutter/constants/theme_constants.dart';
import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:betterself_flutter/components/AppButton.dart';

// intl is required by formbuilder
import 'package:intl/intl.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginFormScreen extends StatefulWidget {
  @override
  _LoginFormScreenState createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('BetterSelf Login')),
      body: FormBuilder(
        key: _fbKey,
        initialValue: {'username': "", "password": ""},
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
                            // maxLength: 16,
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(8),
                              FormBuilderValidators.maxLength(16)
                            ],
                          ),
                          SizedBox(height: 18),
                          AppButton(
                            textContent: "Login",
                            onPressed: () {},
                          ),
                        ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
