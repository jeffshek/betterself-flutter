import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SupplementDetailScreen extends StatefulWidget {
  final Supplement supplement;

  SupplementDetailScreen({Key key, @required this.supplement})
      : super(key: key);

  @override
  _SupplementDetailScreenState createState() => _SupplementDetailScreenState();
}

class _SupplementDetailScreenState extends State<SupplementDetailScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  List<Widget> getViewData(Supplement supplement) {
    return [
      Text(supplement.name),
      Text("Render Data about Supplement"),
    ];
  }

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: "Supplement Name",
                    ),
                    maxLines: 1,
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FormBuilderTextField(
                    minLines: 3,
                    maxLines: 10,
                    attribute: "notes",
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      helperText:
                          "Notes abut the supplement. Is it for mental clarity, strength? etc.",
                      labelText: "Supplement Notes",
                    ),
                    validators: [],
                  ),
                ),
                // ...getViewData(widget.supplement),
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

                        Flushbar(
                          title:  "Success!",
                          icon: Icon(
                            Icons.check,
                            size: 28.0,
                            color: Colors.lightGreenAccent[200],
                          ),
                          message:  "Your changes to ${updatedSupplement.name} have been saved!",
                          duration:  Duration(seconds: 3),
                        )..show(context);

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
