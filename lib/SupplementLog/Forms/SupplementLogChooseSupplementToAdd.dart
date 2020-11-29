import 'dart:developer';

import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/constants/title_constants.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../SupplementLogAddScreen.dart';

class SupplementLogChooseSupplementAddScreen extends StatefulWidget {
  @override
  _SupplementLogChooseSupplementAddScreenState createState() => _SupplementLogChooseSupplementAddScreenState();
}

class _SupplementLogChooseSupplementAddScreenState extends State<SupplementLogChooseSupplementAddScreen> {
  List<Supplement> supplements = [];

  @override
  void initState() {
    _getSupplements();
    super.initState();
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  _getSupplements() async {
    var supplementsData = await getSupplements();
    setState(() => supplements = supplementsData);
  }

  void _onRefresh() async {
    await _getSupplements();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  Widget _renderSupplement(Supplement supplement) {
    return Card(
      child: ListTile(
        leading: Icon(MaterialCommunityIcons.pill),
        title: Text(supplement.name),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) =>
                  SupplementLogAddScreen(supplement: supplement),
            ),
          );

          // _onSupplementTap(supplement);
        },
      ),
    );
  }

  Widget getNewSupplementButton() {
    return WideAppButton(
      textContent: PageActionLabelConstants.CHOOSE_SUPPLEMENT_IN_LOG,
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TitleConstants.SUPPLEMENT_LOGS),
      ),
      drawer: getDrawer(context),
      body: SmartRefresher(
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: getDefaultPaddingInsets(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getNewSupplementButton(),
                    SizedBox(height: 15),
                    for (var item in supplements) _renderSupplement(item),
                    getDefaultPadding(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // getNewSupplementButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO - Pick a Supplement and then pass it onto SupplementLogAdd