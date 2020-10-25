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

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
