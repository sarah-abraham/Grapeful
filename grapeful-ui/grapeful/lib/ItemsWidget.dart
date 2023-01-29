// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, depend_on_referenced_packages, sort_child_properties_last, unnecessary_brace_in_string_interps, avoid_print, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:grapeful/product.dart';
import 'package:grapeful/ItemPage.dart';
import 'package:http/http.dart' as http;

class ItemsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00A368),
                  ),
                ),
                Text(
                  "See All",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ],
            )),
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
                future: gettingData(),
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
                        itemCount: 8, //list data inside snapshot
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
                                                      pname: snapshot
                                                          .data[index].title,
                                                    )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        child: snapshot.data[index].images[0] ==
                                                null
                                            ? Image(
                                                image: AssetImage(
                                                    'images/no_image_available.png'),
                                              )
                                            : Image.network(
                                                '${snapshot.data[index].images[0]}'),
                                        height: 90,
                                        width: 90,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          snapshot.data[index].title,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
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
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
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
                                              "Rs. " +
                                                  snapshot.data[index].price
                                                      .toString(),
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF00A368),
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

Future<List<Datum>> gettingData() async {
  var url = "https://grapeful-api.onrender.com/src/product/";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print("Data Found");
    // print(response.body);
    ProductClass dataModel = productClassFromMap(response.body);
    // print(dataModel.data);
    List<Datum> arrData = dataModel.data;
    // print(arrData);
    //print(arrData[0].name); //fetching data from json for testing
    return arrData;
  } else {
    print("Something went wrong");
    throw Exception("Failed to Fetch");
  }
}
