import 'dart:developer';

import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:betterself_flutter/models/SupplementLog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SupplementLogListScreen extends StatefulWidget {
  @override
  _SupplementLogListScreenState createState() =>
      _SupplementLogListScreenState();
}

class _SupplementLogListScreenState extends State<SupplementLogListScreen> {
  List<SupplementLog> _supplementLogs = [];
  Map<DateTime, List<SupplementLog>> _supplementLogsIndex = {};

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
    for (SupplementLog supplementLog in supplementLogsData) {
      var localTimestamp = supplementLog.time.toLocal();
      DateTime supplementDate = DateTime(
          localTimestamp.year, localTimestamp.month, localTimestamp.day);
      _supplementLogsIndex
          .putIfAbsent(supplementDate, () => [])
          .add(supplementLog);
    }

    setState(() => _supplementLogs = supplementLogsData);
  }

  Widget _renderSupplementLog(SupplementLog supplementLog) {
    var timeFormatted = supplementLog.time.toIso8601String();
    var displayName = supplementLog.displayName;
    var localTimeFormatted = supplementLog.time.toLocal();

    var localTimeDateFormat =
        DateFormat("hh:mm a").format(localTimeFormatted);

    var supplementName = supplementLog.supplement.name;

    var label = "$localTimeDateFormat - $supplementName";

    // print (localTimeDateFormat);

    return Card(
      child: ListTile(
        leading: Icon(MaterialCommunityIcons.pill),
        title: Text(label),
        trailing: Icon(Icons.more_vert),
        // onTap: () {
        //   _onSupplementTap(supplement);
        // },
      ),
    );
  }

  Widget _renderSupplementDateIndex(DateTime index) {
    // var localTimeDateFormat = DateFormat("yyyy-MM-dd hh:mm a").format(index);
    // var localTimeDateFormat = DateFormat("yyyy-MM-dd").format(index);
    var localTimeDateFormat = DateFormat('EEE, MMM d, ''yyyy' ).format(index);

    // all of the supplements that occurred on this date
    var indexSupplementLogs = this._supplementLogsIndex[index];

    return Column(
      // do this to have the text be left centered
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Text(localTimeDateFormat),
        headerText(localTimeDateFormat),
        for (SupplementLog supplementLog in indexSupplementLogs)
          _renderSupplementLog(supplementLog),
        SizedBox(height: 25),
      ],
    );

    return Card(
      child: Card(
        child: ListTile(
          // leading: Icon(MaterialCommunityIcons.pill),
          title: Text(localTimeDateFormat),
          // trailing: Icon(Icons.more_vert),
          // onTap: () {
          //   _onSupplementTap(supplement);
          // },
        ),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // getNewSupplementButton(),
                    SizedBox(height: 15),
                    for (DateTime index in _supplementLogsIndex.keys)
                      _renderSupplementDateIndex(index),
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