import 'package:flutter/material.dart';
import 'package:grapeful_grocery_application/pages/SplashScreen.dart';
import 'package:grapeful_grocery_application/pages/HomePage.dart';

void main(){
  runApp(MyApp());

}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        "/" : (context)=> SplashScreen(),
        "homePage" : (context)=> HomePage(),
        
      },
    );
  }
}


