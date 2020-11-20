import 'package:betterself_flutter/constants/route_constants.dart';
import 'package:betterself_flutter/constants/title_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../main.dart';
import '../theme.dart';

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
              LoginFormRoute,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.pill),
          title: Text(TitleConstants.SUPPLEMENTS),
          onTap: () {
            Navigator.pushNamed(
              context,
              SupplementListRoute,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.plus_box_outline),
          title: Text(TitleConstants.ADD_NEW_SUPPLEMENT),
          onTap: () {
            Navigator.pushNamed(
              context,
              SupplementAddRoute,
            );
          },
        ),
        ListTile(
          leading: Icon(MaterialCommunityIcons.calendar_check),
          title: Text(TitleConstants.SUPPLEMENT_LOGS),
          onTap: () {
            Navigator.pushNamed(
              context,
              SupplementLogListRoute,
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
          leading: Icon(MaterialCommunityIcons.login),
          title: Text('Logout'),
          onTap: () {
            Navigator.pushNamed(
              context,
              LoginFormRoute,
            );
          },
        ),
        // ListTile(
        //   leading: Icon(Icons.account_circle),
        //   title: Text('Profile'),
        // ),
        // ListTile(
        //   leading: Icon(Icons.settings),
        //   title: Text('Settings'),
        // ),
      ],
    ),
  );
}
