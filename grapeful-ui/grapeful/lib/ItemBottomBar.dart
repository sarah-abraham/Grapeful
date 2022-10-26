// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemBottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "cartPage");
            },
            child: Container(
                height: 60,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF00A368),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  CupertinoIcons.cart_fill,
                  color: Colors.white,
                  size: 35,
                ))),
        GestureDetector(
            onTap: () {},
            child: Container(
                height: 60,
                width: 220,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF00A368),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text("Buy Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 1,
                    ))))
      ]),
    );
  }
}
