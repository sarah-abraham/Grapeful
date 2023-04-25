// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors, unused_import

import 'package:flutter/material.dart';
import 'package:grapeful/HomePage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.9],
                  colors: [
                    Color(0xFF81B622),
                    Color(0xFFECF87F),
                  ],
                )),
                child: Column(children: [
                  SizedBox(height: 280),
                  Center(
                    child: Text('Grapeful',
                        style: GoogleFonts.pacifico(
                            fontSize: 90,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFF3D550C))),
                  ),
                  SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      //pushreplacednamed so it cannot go back to splash screen
                      Navigator.pushReplacementNamed(context, "homePage");
                    },
                    //for animation on container
                    child: Container(
                      height: 80,
                      width: 170,
                      // container displaying the text

                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF3D550C),
                      ),
                      child: Center(
                          child: Text("Get Started !",
                              style: TextStyle(
                                color: Color(0xFFECF87F),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ))),
                    ),
                  )
                ]))));
  }
}
