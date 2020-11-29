import 'dart:developer';

import 'package:betterself_flutter/api/resources.dart';
import 'package:betterself_flutter/components/AppButton.dart';
import 'package:betterself_flutter/components/Drawer.dart';
import 'package:betterself_flutter/components/PaddingDefaults.dart';
import 'package:betterself_flutter/components/TextComponents.dart';
import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/constants/title_constants.dart';
import 'package:betterself_flutter/models/SupplementLog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'SupplementLogDetailScreen.dart';

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

  Widget getNewSupplementLogButton() {
    return WideAppButton(
      textContent: TitleConstants.ADD_NEW_SUPPLEMENT_LOG,
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.SUPPLEMENT_LOG_CHOOSE_ADD_SUPPLEMENT_ROUTE);
      },
    );
  }

  _getSupplementLogs() async {
    var supplementLogsData = await getSupplementLogs();

    if (supplementLogsData.length > 100) {
      supplementLogsData = supplementLogsData.sublist(0, 100);
    }

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

  _onSupplementLogTap(SupplementLog supplementLog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SupplementLogDetailScreen(supplementLog: supplementLog),
      ),
    );
  }

  Widget _renderSupplementLog(SupplementLog supplementLog) {
    var localTimeFormatted = supplementLog.time.toLocal();
    var localTimeDateFormat = DateFormat(DateTimeFormatConstants.DAILY_HOUR_LABEL).format(localTimeFormatted);

    var quantity = double.parse(supplementLog.quantity);
    var quantityLabel = quantity.toStringAsFixed(0);

    var supplementName = supplementLog.supplement.name;
    var label = "$quantityLabel x $supplementName";

    return Card(
      child: ListTile(
        leading: Text(localTimeDateFormat),
        title: Text(label),
        subtitle: Text(supplementLog.notes),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          _onSupplementLogTap(supplementLog);
        },
      ),
    );
  }

  Widget _renderSupplementDateIndex(DateTime index) {
    // var localTimeDateFormat = DateFormat("yyyy-MM-dd hh:mm a").format(index);
    // var localTimeDateFormat = DateFormat("yyyy-MM-dd").format(index);
    var localTimeDateFormat = DateFormat(DateTimeFormatConstants.WEEKDAY_MONTH_DAY_YEAR).format(index);

    // all of the supplements that occurred on this date
    var indexSupplementLogs = this._supplementLogsIndex[index];

    return Column(
      // do this to have the text be left centered
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        headerText(localTimeDateFormat),
        SizedBox(height: 5),
        for (SupplementLog supplementLog in indexSupplementLogs)
          _renderSupplementLog(supplementLog),
        SizedBox(height: 25),
      ],
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
                    getNewSupplementLogButton(),
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
