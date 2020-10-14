import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'HomePage/HomePage.dart';
import 'Login/LoginFormScreen.dart';
import 'Login/LoginScreen.dart';
import 'constants/route_constants.dart';

const AppName = "BetterSelf";
const AppTitle = "BetterSelf";

var routes = <String, WidgetBuilder>{
  HomeRoute: (context) => HomePageScreen(),
  LoginRoute: (context) => LoginScreen(),
  LoginFormRoute: (context) => LoginFormScreen(),
};

var _app = MaterialApp(
    title: AppName,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    // initialRoute: LoginRoute,
    initialRoute: LoginFormRoute,
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
