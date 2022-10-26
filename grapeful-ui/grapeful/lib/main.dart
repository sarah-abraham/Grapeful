import 'package:flutter/material.dart';
import 'package:grapeful/CartItemSamples.dart';
import 'package:grapeful/CartPage.dart';
import 'package:grapeful/ItemPage.dart';
import 'package:grapeful/SplashScreen.dart';
import 'package:grapeful/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "homePage": (context) => HomePage(),
        "itemPage": (context) => ItemPage(),
        "cartPage": (context) => CartPage()
      },
    );
  }
}
