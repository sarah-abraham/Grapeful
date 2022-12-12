import 'package:flutter/material.dart';
import 'package:grapeful/CartItemSamples.dart';
import 'package:grapeful/CartPage.dart';
import 'package:grapeful/ItemPage.dart';
import 'package:grapeful/SplashScreen.dart';
import 'package:grapeful/HomePage.dart';
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
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => SplashScreen(),
        "/auth-screen": (context) => AuthScreen(),
        "homePage": (context) => HomePage(),
        "itemPage": (context) => ItemPage(),
        "cartPage": (context) => CartPage()
      },
    );
  }
}
