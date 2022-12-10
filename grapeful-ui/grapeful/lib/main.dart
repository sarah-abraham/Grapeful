import 'package:flutter/material.dart';
import 'package:grapeful/CartItemSamples.dart';
import 'package:grapeful/CartPage.dart';
import 'package:grapeful/ItemPage.dart';
import 'package:grapeful/SplashScreen.dart';
import 'package:grapeful/HomePage.dart';
import 'package:grapeful/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      routes: {
        "/": (context) => SplashScreen(),
        "homePage": (context) => HomePage(),
        "itemPage": (context) => ItemPage(),
        "cartPage": (context) => CartPage()
      },
    );
  }
}
