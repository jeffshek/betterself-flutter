import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/constants/title_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:betterself_flutter/main.dart';
import 'package:betterself_flutter/theme.dart';

_launchBetterSelfURL() async {
  const url = 'https://app.betterself.io/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget getDrawer(context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
          decoration: BoxDecoration(
            color: PRIMARY_COLOR,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              AppName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.login),
          title: Text(TitleConstants.LOGIN),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteConstants.LOGIN_FORM_ROUTE,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.pill),
          title: Text(TitleConstants.SUPPLEMENTS),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteConstants.SUPPLEMENT_LIST_ROUTE,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.plus_box_outline),
          title: Text(TitleConstants.ADD_NEW_SUPPLEMENT),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteConstants.SUPPLEMENT_ADD_ROUTE,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.calendar_check),
          title: Text(TitleConstants.SUPPLEMENT_LOGS),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteConstants.SUPPLEMENT_LOG_LIST_ROUTE,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.calendar),
          title: Text(TitleConstants.ADD_NEW_SUPPLEMENT_LOG),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteConstants.SUPPLEMENT_LOG_CHOOSE_ADD_SUPPLEMENT_ROUTE,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.access_point_network),
          title: Text('Access Analytics (Web)'),
          onTap: () {
            _launchBetterSelfURL();
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.login),
          title: Text('Logout'),
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteConstants.LOGOUT_ROUTE,
            );
          },
        ),
      ],
    ),
  );
}
