import 'package:flutter/material.dart';
import 'package:grapeful/HomePage.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case HomePage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        // ignore: prefer_const_constructors
        builder: (_) => HomePage(),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        // ignore: prefer_const_constructors
        builder: (_) =>
            const Scaffold(body: Center(child: Text('Screen does not exist'))),
      );
  }
}
