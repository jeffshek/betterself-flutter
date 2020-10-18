import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:flutter/material.dart';

class SupplementListScreen extends StatefulWidget {
  @override
  _SupplementListScreenState createState() => _SupplementListScreenState();
}

class _SupplementListScreenState extends State<SupplementListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                headerText("Supplements"),
                SizedBox(width: 4),
                Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: subheaderText("Login"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
