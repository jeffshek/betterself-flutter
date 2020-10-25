import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'Forms/SupplementForm.dart';

class SupplementDetailScreen extends StatefulWidget {
  final Supplement supplement;

  SupplementDetailScreen({Key key, @required this.supplement})
      : super(key: key);

  @override
  _SupplementDetailScreenState createState() => _SupplementDetailScreenState();
}

class _SupplementDetailScreenState extends State<SupplementDetailScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.supplement.name),
      ),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            'name': "${widget.supplement.name}",
            "notes": "${widget.supplement.notes}"
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
                      textContent: "Save Changes",
                      onPressed: () async {
                        _fbKey.currentState.saveAndValidate();

                        final currentStateValues = _fbKey.currentState.value;
                        final supplement = widget.supplement;

                        supplement.name = currentStateValues['name'];
                        supplement.notes = currentStateValues['notes'];

                        final updatedSupplement = await updateSupplement(supplement);

                        final message = "Your changes to ${updatedSupplement.name} have been saved!";
                        getSuccessSnackbarNotification(context, message);

                        FocusManager.instance.primaryFocus.unfocus();
                      },
                    ),
                    SizedBox(width: 10),
                    NarrowButton(
                      textContent: "Add New Log",
                      onPressed: () {},
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
