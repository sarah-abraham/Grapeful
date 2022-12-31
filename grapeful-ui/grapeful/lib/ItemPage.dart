// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, unused_label, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:grapeful/ItemBottomBar.dart';
import 'package:grapeful/product.dart';
import 'package:http/http.dart' as http;

class ItemPage extends StatelessWidget {
  final int index;
  const ItemPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: gettingData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Container(
                      color: Color.fromARGB(255, 172, 242, 216),
                      width: double.infinity,
                      height: 390,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "homePage");
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        size: 28,
                                      )),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
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
                          Container(
                            margin: EdgeInsets.all(10),
                            child: snapshot.data[index].images[0] == null
                                ? Image(
                                    image: AssetImage(
                                        'images/no_image_available.png'),
                                  )
                                : Image.network(
                                    '${snapshot.data[index].images[0]}'),
                            height: 264,
                            width: 264,
                          ),
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                        )
                      ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(snapshot.data[index].title,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                          Column(
                            children: [
                              Text(
                                  "Rs. " +
                                      snapshot.data[index].price.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  )),
                              SizedBox(height: 5),
                              Text(snapshot.data[index].quantity[0],
                                  style: TextStyle(
                                    fontSize: 16,
                                  ))
                            ],
                          )
                        ],
                      )),
                  SizedBox(height: 15),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration:
                          BoxDecoration(color: Colors.white, boxShadow: [
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
                            snapshot.data[index].description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      )),
                  SizedBox(height: 15),
                ],
              );
            }
            return CircularProgressIndicator();
          }),
      bottomNavigationBar: ItemBottomBar(),
    );
  }
}

Future<List<Datum>> gettingData() async {
  var url = "https://grapeful-api.onrender.com/src/product/";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print("Data Found");
    ProductClass dataModel = productClassFromMap(response.body);
    //print(dataModel.support.url);
    List<Datum> arrData = dataModel.data;
    print(arrData);
    //print(arrData[0].name); //fetching data from json for testing
    return arrData;
  } else {
    throw Exception("Failed to Fetch");
  }
}
