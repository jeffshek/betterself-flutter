import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:betterself_flutter/navigator_utilities.dart';
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
          initialValue: {'name': "", "notes": ""},
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
                        var supplement = Supplement();

                        supplement.name = currentStateValues['name'];
                        supplement.notes = currentStateValues['notes'];

                        try {
                          supplement = await createSupplement(supplement, context);
                          final message = "${supplement.name} has been created!";
                          pushSupplementDetails(supplement, context);
                          getSuccessSnackbarNotification(context, message);
                        } catch (err) {

                        }

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
