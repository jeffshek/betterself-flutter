import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'Forms/SupplementForm.dart';

class SupplementAddScreen extends StatefulWidget {
  @override
  _SupplementAddScreenState createState() => _SupplementAddScreenState();
}

class _SupplementAddScreenState extends State<SupplementAddScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Supplement'),
      ),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            'name': "",
            "notes": ""
          },
          autovalidate: true,
          child: Container(
            child: Column(
              children: [
                getSafeAreaDefault(context),
                ...getSupplementFormFields(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NarrowButton(
                      textContent: "Create Supplement",
                      onPressed: () async {
                        _fbKey.currentState.saveAndValidate();

                        final currentStateValues = _fbKey.currentState.value;
                        print (currentStateValues);

                        // Flushbar(
                        //   title:  "Success!",
                        //   icon: Icon(
                        //     Icons.check,
                        //     size: 28.0,
                        //     color: Colors.lightGreenAccent[200],
                        //   ),
                        //   message:  "${updatedSupplement.name} has been created!",
                        //   duration:  Duration(seconds: 3),
                        // )..show(context);

                        FocusManager.instance.primaryFocus.unfocus();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
