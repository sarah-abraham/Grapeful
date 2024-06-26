// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grapeful/CartItemSamples.dart';
import 'package:grapeful/CartScreen.dart';
import 'package:grapeful/CategoryProductWidget.dart';
import 'package:grapeful/ItemPage.dart';
import 'package:grapeful/SplashScreen.dart';
import 'package:grapeful/HomePage2.dart';
import 'package:grapeful/auth_screen.dart';
import 'package:grapeful/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:grapeful/bottom_bar.dart';
import 'package:grapeful/router.dart';
import 'package:grapeful/global_variables.dart';
import 'package:grapeful/auth_screen.dart';
import 'package:grapeful/auth_service.dart';
import 'package:grapeful/user_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// class _MyAppState extends State<MyApp> {
//   final AuthService authService = AuthService();

//   @override
//   void initState() {
//     super.initState();
//     authService.getUserData(context);
//   }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) => generateRoute(settings),
      routes: {
        "/": (context) => SplashScreen(),
        "/auth-screen": (context) => AuthScreen(),
        "homePage": (context) => HomePage(),
        "itemPage": (context) => ItemPage(
              pname: "None",
            ),
        // "cartPage": (context) => CartPage(),
        "cartScreen": (context) => CartScreen(),
        "categoryDetailsPage": (context) => CategoryProductWidget(
              index: 0,
            )
      },
    );
  }
}
