import 'package:betterself_flutter/SupplementLog/Forms/SupplementLogForm.dart';
import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/Notifications.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/models/SupplementLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SupplementLogDetailScreen extends StatefulWidget {
  final SupplementLog supplementLog;

  SupplementLogDetailScreen({Key key, @required this.supplementLog})
      : super(key: key);

  @override
  _SupplementLogDetailScreenState createState() =>
      _SupplementLogDetailScreenState();
}

class _SupplementLogDetailScreenState extends State<SupplementLogDetailScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit ${widget.supplementLog.displayName} Log"),
      ),
      drawer: getDrawer(context),
      body: SingleChildScrollView(
        child: FormBuilder(
          key: _fbKey,
          initialValue: {
            "time": widget.supplementLog.time,
            "quantity": widget.supplementLog.quantity,
            "notes": widget.supplementLog.notes
          },
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
                      textContent: "Edit ${widget.supplementLog.displayName}",
                      onPressed: () async {
                        _fbKey.currentState.saveAndValidate();

                        final currentStateValues = _fbKey.currentState.value;
                        final instance = widget.supplementLog;

                        instance.time = currentStateValues['time'];
                        instance.quantity = currentStateValues['quantity'];
                        instance.notes = currentStateValues['notes'];

                        final updatedInstance =
                            await updateSupplementLog(instance);

                        final message =
                            "Your changes to ${updatedInstance.supplement.name} Log have been saved!";
                        getSuccessSnackbarNotification(context, message);

                        FocusManager.instance.primaryFocus.unfocus();

                        Navigator.pushNamed(
                            context, RouteConstants.SUPPLEMENT_LOG_LIST_ROUTE);
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
