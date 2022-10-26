// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class CartItemSamples extends StatefulWidget {
  @override
  State<CartItemSamples> createState() => _CartItemSamplesState();
}

class _CartItemSamplesState extends State<CartItemSamples> {
  bool checkedvalue = false;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  activeColor: Color(0xFFFFB608),
                  value: checkedvalue,
                  onChanged: (newValue) {
                    setState(() {
                      checkedvalue = newValue!;
                    });
                  },
                ),
                Container(
                    height: 70,
                    width: 70,
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 172, 242, 216),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 8,
                          )
                        ]),
                    child: Image.asset(
                      "images/1.png",
                      fit: BoxFit.contain,
                    )),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Text("Item Name",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(162, 0, 0, 0),
                            )),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Text("Rs. 50",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(162, 0, 0, 0),
                                ))
                          ],
                        )
                      ],
                    ))
              ],
            )
          ],
        ));
  }
}
