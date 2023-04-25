// ignore: file_names
// ignore_for_file: depend_on_referenced_packages, implementation_imports, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import, unnecessary_null_comparison, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_print, prefer_interpolation_to_compose_strings, dead_code
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:grapeful/CartScreen.dart';
import 'package:grapeful/HomeBottomBar.dart';
import 'package:grapeful/ItemsWidget.dart';
import 'package:grapeful/PopularItemsWidget.dart';
import 'package:grapeful/CategoriesWidget.dart';
import 'package:grapeful/CategoryProductWidget.dart';
import 'package:grapeful/cart_controller.dart';
import 'package:grapeful/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grapeful/recognization_page.dart';
import 'package:grapeful/image_cropper_page.dart';
import 'package:grapeful/image_picker_class.dart';
import 'package:grapeful/modal_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:provider/provider.dart';
import 'ItemPage.dart';
import 'product.dart' show Datum;
import 'dart:io';

class HomePage extends StatelessWidget {
  final String selectedItem = ''; //name of item
  static const String routeName = '/HomePage';

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF81B622),
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
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          color: Color(0xFF81B622),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 2,
                            ),
                          ]),
                      child: InkWell(
                        onTap: () {
                          final cartController = Get.put(CartController());
                          Get.to(() => CartScreen());
                        },
                        child: Icon(
                          CupertinoIcons.cart,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ) //),
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
                      "Welcome to Grapeful",
                      style: GoogleFonts.raleway(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              //Search Widget
              InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: CustomSearch());
                  },
                  child: Container(
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              showSearch(
                                  context: context, delegate: CustomSearch());
                            },
                            icon: const Icon(Icons.search)),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 250,
                        ),
                      ],
                    ),
                  )),

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
                    ItemsWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF81B622),
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
      // bottomNavigationBar: HomeBottomBar(),
    );
  }
}

//to create display search function that contains data and has set function

class CustomSearch extends SearchDelegate {
  Future<Object> allData(String value) async {
    List<Datum> arrData1 = [];
    List<String> productTitleAdded = [];
    var url = "https://grapeful-api.onrender.com/src/productTitle/";
    var response = await http.get(Uri.parse(url));
    List<int> found_index = [];
    if (response.statusCode == 200 && query != null) {
      // ignore: avoid_print

      ProductClass dataModel = productClassFromMap(response.body);

      List<Datum> arrData = dataModel.data;
      for (int i = 0; i < arrData.length; i++) {
        String productTitle = arrData[i].title;

        if (productTitle.toLowerCase().contains(value.toLowerCase())) {
          //add productTitles to array
          productTitleAdded.add(productTitle);
          print("-------------------------------------------------");
          print("Hey!!!!! I FOUND A MATCH");
          print(value);
          print(productTitle);
          print("-------------------------------------------------");
          found_index.add(i);
        }
      }
    }
    if (query != null) {
      for (int j = 0; j < productTitleAdded.length; j++) {
        print(productTitleAdded.length);
        var product_url =
            "https://grapeful-api.onrender.com/src/productTitle/" +
                productTitleAdded[j];
        var response = await http.get(Uri.parse(product_url));
        if (response.statusCode == 200) {
          // ignore: avoid_print
          print("Data Found");
          ProductClass dataModel = productClassFromMap(response.body);

          List<Datum> arrData1 = dataModel.data;
          print(arrData1);
          //print(arrData[0].name); //fetching data from json for testing
          return arrData1;
        } else {
          throw Exception("Failed to Fetch");
        }
      }
    }

    return SizedBox();
  }

  // // ignore: non_constant_identifier_names

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = ''; //value in our textbox
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  //only display result
  Widget buildResults(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: allData(query),
            // changed to all data
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (query != null && snapshot.hasData) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: snapshot.data.length, //list data inside snapshot
                    itemBuilder: (BuildContext context, int index) {
                      if (snapshot.hasData) {
                        return InkWell(
                            onTap: () {
                              //NAME COMING FROM MODEL CLASS
                              print(snapshot.data[index].productid);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => ItemPage(
                                                    pname: snapshot
                                                        .data[index].title,
                                                  )));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      // ignore: sort_child_properties_last
                                      child: snapshot.data[index].images[0] ==
                                              null
                                          ? Image(
                                              image: AssetImage(
                                                  'images/no_image_available.png'),
                                            )
                                          : Image.network(
                                              '${snapshot.data[index].images[0]}'),
                                      height: 80,
                                      width: 80,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data[index].title,
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF555555),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child:
                                          Text(snapshot.data[index].quantity[0],
                                              style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF555555),
                                              )),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            "Rs. " +
                                                snapshot.data[index].price
                                                    .toString(),
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 23, 187, 114),
                                            ),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ));
                      }

                      return SizedBox();
                    });
                return SizedBox();
              }
              return SizedBox();
            }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox();
  }
}
