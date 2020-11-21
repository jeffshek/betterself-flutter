import 'package:betterself_flutter/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'HomePage/HomePage.dart';
import 'Login/LoginFormScreen.dart';
import 'Logout/LogoutScreen.dart';
import 'Supplement/SupplementAddScreen.dart';
import 'Supplement/SupplementListScreen.dart';
import 'SupplementLog/Forms/SupplementLogChooseSupplementToAdd.dart';
import 'SupplementLog/SupplementLogListScreen.dart';
import 'constants/route_constants.dart';

const AppName = "BetterSelf";
const AppTitle = "BetterSelf";

var routes = <String, WidgetBuilder>{
  RouteConstants.HOME_ROUTE: (context) => HomePageScreen(),
  RouteConstants.LOGIN_FORM_ROUTE: (context) => LoginFormScreen(),
  RouteConstants.SUPPLEMENT_LIST_ROUTE: (context) => SupplementListScreen(),
  RouteConstants.SUPPLEMENT_ADD_ROUTE: (context) => SupplementAddScreen(),
  RouteConstants.SUPPLEMENT_LOG_CHOOSE_ADD_SUPPLEMENT_ROUTE: (context) => SupplementLogChooseSupplementAddScreen(),
  RouteConstants.SUPPLEMENT_LOG_LIST_ROUTE: (context) => SupplementLogListScreen(),
  RouteConstants.LOGOUT_ROUTE: (context) => LogoutScreen(),
};

var _app = MaterialApp(
    title: AppName,
    theme: ThemeData(
      primarySwatch: PRIMARY_COLOR,
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    initialRoute: RouteConstants.LOGIN_FORM_ROUTE,
    // initialRoute: SupplementLogListRoute,
    // initialRoute: SupplementListRoute,
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
