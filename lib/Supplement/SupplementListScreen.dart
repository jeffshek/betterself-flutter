import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/constants/title_constants.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await _getSupplements();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  _getSupplements() async {
    var supplementsData = await getSupplements();
    setState(() => supplements = supplementsData);
  }

  Widget getNewSupplementButton() {
    return WideAppButton(
      textContent: TitleConstants.ADD_NEW_SUPPLEMENT,
      onPressed: () {
        Navigator.pushNamed(context, SupplementAddRoute);
      },
    );
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
      appBar: AppBar(
        title: const Text('Supplements'),
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
                          getNewSupplementButton(),
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
