// ignore: file_names
// ignore_for_file: depend_on_referenced_packages, implementation_imports, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:grapeful/CartPage.dart';
import 'package:grapeful/ItemsWidget.dart';
import 'package:grapeful/PopularItemsWidget.dart';
import 'package:grapeful/CategoriesWidget.dart';

import 'package:image_picker/image_picker.dart';
import 'package:grapeful/recognization_page.dart';
import 'package:grapeful/image_cropper_page.dart';
import 'package:grapeful/image_picker_class.dart';
import 'package:grapeful/modal_dialog.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00A368),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //custom App Bar
              Container(
                padding: EdgeInsets.only(right: 20, left: 15, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                    Container(
                        //padding:EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Color(0xFF00A368),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.5),
                                blurRadius: 2,
                              ),
                            ]),
                        child: Badge(
                          badgeColor: Colors.red,
                          padding: EdgeInsets.all(7),
                          badgeContent: Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "cartPage");
                            },
                            child: Icon(
                              CupertinoIcons.cart,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),

              //Welcome Text
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "What do you want to Buy?",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),

              //Search Widget
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search here...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.filter_list),
                  ],
                ),
              ),

              //Products Widgets
              Container(
                padding: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesWidget(),
                    PopularItemsWidget(),
                    ItemsWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.greenAccent,
        onPressed: () {
          imagePickerModal(context, onCameraTap: () {
            pickImage(source: ImageSource.camera).then((value) {
              if (value != '') {
                imageCropperView(value, context).then((value) {
                  if (value != '') {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => RecognizePage(
                          path: value,
                        ),
                      ),
                    );
                  }
                });
              }
            });
          }, onGalleryTap: () {
            pickImage(source: ImageSource.gallery).then((value) {
              if (value != '') {
                imageCropperView(value, context).then((value) {
                  if (value != '') {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => RecognizePage(
                          path: value,
                        ),
                      ),
                    );
                  }
                });
              }
            });
          });
        },
        tooltip: 'Increment',
        label: const Text("Scan photo"),
      ),
    );
  }
}
