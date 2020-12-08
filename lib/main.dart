import 'dart:developer';

import 'package:betterself_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'Login/LoginFormScreen.dart';
import 'Logout/LogoutScreen.dart';
import 'Register/RegisterScreen.dart';
import 'Supplement/SupplementAddScreen.dart';
import 'Supplement/SupplementListScreen.dart';
import 'SupplementLog/Forms/SupplementLogChooseSupplementToAdd.dart';
import 'SupplementLog/SupplementLogListScreen.dart';
import 'api/constants.dart';
import 'constants/route_constants.dart';

var routes = <String, WidgetBuilder>{
  RouteConstants.LOGIN_FORM_ROUTE: (context) => LoginFormScreen(),
  RouteConstants.SUPPLEMENT_LIST_ROUTE: (context) => SupplementListScreen(),
  RouteConstants.SUPPLEMENT_ADD_ROUTE: (context) => SupplementAddScreen(),
  RouteConstants.SUPPLEMENT_LOG_CHOOSE_ADD_SUPPLEMENT_ROUTE: (context) => SupplementLogChooseSupplementAddScreen(),
  RouteConstants.SUPPLEMENT_LOG_LIST_ROUTE: (context) => SupplementLogListScreen(),
  RouteConstants.LOGOUT_ROUTE: (context) => LogoutScreen(),
  RouteConstants.REGISTER_ROUTE: (context) => RegisterScreen(),
};

const bool isProduction = bool.fromEnvironment('dart.vm.product');

var _app = MaterialApp(
    title: AppName,
    theme: ThemeData(
      primarySwatch: PRIMARY_COLOR,
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) t®han on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    initialRoute: RouteConstants.LOGIN_FORM_ROUTE,
    routes: routes);

class BetterSelfApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) => _app);
  }
}

void main() {
  runApp(BetterSelfApp());
}
