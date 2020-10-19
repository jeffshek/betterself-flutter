import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/RouteHeadingTextPadding.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:flutter/material.dart';

class SupplementListScreen extends StatefulWidget {
  @override
  _SupplementListScreenState createState() => _SupplementListScreenState();
}

class _SupplementListScreenState extends State<SupplementListScreen> {
  @override
  void initState() {
    _getSupplements();
    super.initState();
  }

  _getSupplements() async {
    getSupplements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            getSafeAreaDefault(context),
            getRouteHeaderTextPadding("Supplements"),
            Padding(
              padding: getDefaultPaddingInsets(),
              child: Column(
                children: <Widget>[
                  getDefaultPadding(),
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 25),
                        SizedBox(height: 18),
                        AppButton(
                          textContent: "Add Supplement",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
