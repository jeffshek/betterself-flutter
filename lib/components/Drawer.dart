import 'package:betterself_flutter/constants/route_constants.dart';
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
          leading: Icon(MaterialCommunityIcons.pill),
          title: Text('Supplements'),
          onTap: () {
            Navigator.pushNamed(
              context,
              SupplementListRoute,
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.account_circle),
          title: Text('Profile'),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
      ],
    ),
  );
}
