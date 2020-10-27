import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/models/Supplement.dart';
import 'package:betterself_flutter/models/SupplementLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SupplementLogListScreen extends StatefulWidget {
  @override
  _SupplementLogListScreenState createState() => _SupplementLogListScreenState();
}

class _SupplementLogListScreenState extends State<SupplementLogListScreen> {
  List<SupplementLog> supplementLogs = [];

  @override
  void initState() {
    _getSupplementLogs();
    super.initState();
  }

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await _getSupplementLogs();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _refreshController.loadComplete();
  }

  _getSupplementLogs() async {
    var supplementLogsData = await getSupplementLogs();
    setState(() => supplementLogs = supplementLogsData);
  }

  Widget _renderSupplementLog(SupplementLog supplementLog) {

    var timeFormatted = supplementLog.time.toIso8601String();
    var displayName = supplementLog.displayName;

    return Card(
      child: ListTile(
        leading: Icon(MaterialCommunityIcons.pill),
        title: Text(displayName),
        trailing: Icon(Icons.more_vert),
        // onTap: () {
        //   _onSupplementTap(supplement);
        // },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplement Logs'),
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
                    // getNewSupplementButton(),
                    SizedBox(height: 15),
                    for (var item in supplementLogs) _renderSupplementLog(item),
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
