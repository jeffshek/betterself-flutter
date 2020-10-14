import 'package:flutter/material.dart';
import 'package:betterself_flutter/constants/theme_constants.dart';

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
      appBar: AppBar(title: Text('FormBuilder!')),
      body: FormBuilder(
        key: _fbKey,
        initialValue: {
          'date': DateTime.now(),
          'accept_terms': false,
        },
        child: Column(
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
                child: Column(
                  children: <Widget>[
                    FormBuilderTextField(
                      attribute: "username",
                      decoration: InputDecoration(labelText: "User Name"),
                    ),
                    FormBuilderDateTimePicker(
                      attribute: "date",
                      inputType: InputType.date,
                      format: DateFormat("yyyy-MM-dd"),
                      decoration:
                          InputDecoration(labelText: "Appointment Time"),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
