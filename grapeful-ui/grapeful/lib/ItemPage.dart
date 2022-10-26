// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:grapeful/ItemBottomBar.dart';

class ItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              color: Color.fromARGB(255, 172, 242, 216),
              width: double.infinity,
              height: 390,
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Column(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "homePage");
                              },
                              child: Icon(
                                Icons.arrow_back,
                                size: 28,
                              )),
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                    )
                                  ]),
                              child: Icon(
                                Icons.favorite,
                                size: 30,
                                color: Color(0xFF00A368),
                              ))
                        ],
                      )),
                  Image.asset(
                    "images/2.png",
                    height: 280,
                    width: 280,
                    fit: BoxFit.contain,
                  )
                ],
              )),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Item Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  Column(
                    children: [
                      Text("Rs. 50",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )),
                      SizedBox(height: 5),
                      Text("400 Gram",
                          style: TextStyle(
                            fontSize: 16,
                          ))
                    ],
                  )
                ],
              )),
          SizedBox(height: 15),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Product Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: 8),
                  Text(
                    "This is the description of the product.This is the description of the product.This is the description of the product.This is the description of the product.This is the description of the product.This is the description of the product.",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              )),
          SizedBox(height: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Recommended Products",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ))),
              SizedBox(height: 5),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      for (int i = 1; i < 9; i++)
                        Container(
                            height: 90,
                            width: 90,
                            padding: EdgeInsets.all(5),
                            margin:
                                EdgeInsets.only(top: 8, bottom: 8, left: 20),
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
                              "images/$i.png",
                              fit: BoxFit.contain,
                            ))
                    ],
                  ))
            ],
          )
        ],
      ),
      bottomNavigationBar: ItemBottomBar(),
    );
  }
}
