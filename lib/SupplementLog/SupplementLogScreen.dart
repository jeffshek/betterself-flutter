import 'package:betterself_flutter/SupplementLog/Forms/SupplementLogForm.dart';
import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:betterself_flutter/navigator_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SupplementLogAddScreen extends StatefulWidget {
  final Supplement supplement;

  SupplementLogAddScreen({Key key, @required this.supplement})
      : super(key: key);

  @override
  _SupplementLogAddScreenState createState() => _SupplementLogAddScreenState();
}

class _SupplementLogAddScreenState extends State<SupplementLogAddScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add ${widget.supplement.name} Log"),
      ),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          initialValue: {"time": DateTime.now(), "quantity": "1", "notes": ""},
          autovalidate: true,
          child: Container(
            child: Column(
              children: [
                getSafeAreaDefault(context),
                ...getSupplementLogFormFields(),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NarrowButton(
                      textContent: "Log ${widget.supplement.name}",
                      onPressed: () async {
                        _fbKey.currentState.saveAndValidate();

                        final currentStateValues = _fbKey.currentState.value;
                        var supplement = Supplement();

                        supplement.name = currentStateValues['name'];
                        supplement.notes = currentStateValues['notes'];

                        try {
                          supplement =
                              await createSupplement(supplement, context);
                          final message =
                              "${supplement.name} has been created!";
                          pushSupplementDetails(supplement, context);
                          getSuccessSnackbarNotification(context, message);
                        } catch (err) {}

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
