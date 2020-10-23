import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/RouteHeadingTextPadding.dart';
import 'package:betterself_flutter/components/SafeAreaDefault.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'SupplementDetailScreen.dart';

class SupplementListScreen extends StatefulWidget {
  @override
  _SupplementListScreenState createState() => _SupplementListScreenState();
}

class _SupplementListScreenState extends State<SupplementListScreen> {
  List<Supplement> supplements = [];

  @override
  void initState() {
    _getSupplements();
    super.initState();
  }

  _getSupplements() async {
    var supplementsData = await getSupplements();
    setState(() => supplements = supplementsData);
  }

  _onSupplementTap(Supplement supplement) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SupplementDetailScreen(supplement: supplement),
      ),
    );
  }

  Widget _renderSupplement(Supplement supplement) {
    return Card(
      child: ListTile(
        leading: Icon(MaterialCommunityIcons.pill),
        // leading: FlutterLogo(),
        title: Text(supplement.name),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          _onSupplementTap(supplement);
        },
      ),
    );
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
                  AppButton(
                    textContent: "Add New Supplement",
                    onPressed: () {},
                  ),
                  SizedBox(height: 15),
                  for (var item in supplements) _renderSupplement(item),
                  getDefaultPadding(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // SizedBox(height: 5),
                        AppButton(
                          textContent: "Add New Supplement",
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
