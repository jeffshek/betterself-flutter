import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
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
          child: Column(
            children: [
              // getSafeAreaDefault(context),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: NarrowButton(
                  textContent: "Add Log",
                  onPressed: () {},
                ),
              ),
              ...getViewData(widget.supplement),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: NarrowButton(
                  textContent: "Save Update",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
