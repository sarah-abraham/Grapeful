// ignore: file_names
// ignore_for_file: depend_on_referenced_packages, implementation_imports, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, unused_import, unnecessary_null_comparison, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_print, prefer_interpolation_to_compose_strings
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/icons.dart';
import 'package:grapeful/CartPage.dart';
import 'package:grapeful/HomeBottomBar.dart';
import 'package:grapeful/ItemsWidget.dart';
import 'package:grapeful/PopularItemsWidget.dart';
import 'package:grapeful/CategoriesWidget.dart';
import 'package:grapeful/CategoryProductWidget.dart';
import 'package:grapeful/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grapeful/recognization_page.dart';
import 'package:grapeful/image_cropper_page.dart';
import 'package:grapeful/image_picker_class.dart';
import 'package:grapeful/modal_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'ItemPage.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/HomePage';

  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 150, 93),
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
                          color: Color.fromARGB(255, 50, 150, 93),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              blurRadius: 2,
                            ),
                          ]),
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
                      "Welcome",
                      style: GoogleFonts.raleway(
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
                    IconButton(
                        onPressed: () {
                          showSearch(
                              context: context, delegate: CustomSearch());
                        },
                        icon: const Icon(Icons.search)),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Search here...",
                          border: InputBorder.none,
                        ),
                        // onChanged: (value) => display_search(value),
                        // onChanged: (value) => updateList(value),
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
      // bottomNavigationBar: HomeBottomBar(),
    );
  }
}

// final CustomSearch query = CustomSearch();

// display_search(String value) {
//   print(value);
//   void setState(CustomSearch()) {
//     List<Datum> arrData = query.allData() as List<Datum>;
//     List<Datum> displayList = arrData
//         .where((element) =>
//             element.title.toLowerCase().contains(value.toLowerCase()))
//         .toList();
//   }
// }

//to create display search function that contains data and has set function

class CustomSearch extends SearchDelegate {
  Future<List<Datum>> allData(String value) async {
    var url = "https://grapeful-api.onrender.com/src/productTitle/" + value;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("Data Found");
      ProductClass dataModel = productClassFromMap(response.body);
      //print(dataModel.support.url);
      List<Datum> arrData = dataModel.data; //this is all my
      print(arrData);
      return arrData;
    } else {
      throw Exception("Failed to Fetch");
    }
  }

  // // ignore: non_constant_identifier_names

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            // searchquery = '';
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
    return FutureBuilder(
        future: allData(query),
        // changed to all data
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (query != null) {
            return GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemCount: snapshot.data.length, //list data inside snapshot
                itemBuilder: (BuildContext context, int index) {
                  // print("${snapshot.data[index].title}");
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ItemPage(
                                          index: index,
                                        )));
                              },
                              child: Container(
                                margin: EdgeInsets.all(10),
                                // ignore: sort_child_properties_last
                                child: snapshot.data[index].images[0] == null
                                    ? Image(
                                        image: AssetImage(
                                            'images/no_image_available.png'),
                                      )
                                    : Image.network(
                                        '${snapshot.data[index].images[0]}'),
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  snapshot.data[index].title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 22,
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
                                child: Text(snapshot.data[index].quantity[0],
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
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
                                          snapshot.data[index].price.toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 23, 187, 114),
                                      ),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ));
                  // return Text("Error while calling getData()");
                });
          }
          return Text("Error while calling getData() ${snapshot.error}");
          ;
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 1,
          childAspectRatio: 1.7,
          shrinkWrap: true,
          children: <Widget>[
            // for (int i = 1; i < 8; i++)
            FutureBuilder(
                future: allData(query),
                // changed to all data
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    // print("${snapshot.data[0].title}");
                    return GridView.builder(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: 0,
                        // snapshot.data.length, //list data inside snapshot
                        itemBuilder: (BuildContext context, int index) {
                          // print("${snapshot.data[index].title}");
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
                                                      index: index,
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
                                        height: 100,
                                        width: 100,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: GoogleFonts.poppins(
                                            fontSize: 22,
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
                                        child: Text(
                                            snapshot.data[index].quantity[0],
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF555555),
                                            )),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
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
                                                fontSize: 20,
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
                          // return Text("Error while calling getData()");
                        });
                  }
                  return Text(
                      "Error while calling getData() ${snapshot.error}");
                  ;
                }),
            // ))
          ],
        ),
      ],
    );
  }
}

// build suggestions and build results is my feed screen
//inside the grid view he created a child that ia automatically generated
//iske andar customsearch hai
//body or child is fine
// body:GridView.count(
//   children:List.generate(productsList.length, (index){
//     return ChangeNotifierProvider.value(value:(
//       value:productsList[index],
//       child:FeedProducts(),
//     ))
//   })
// )
//if feed is function where products are displayed
//feed products are the products displayed on feed
