// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings, unnecessary_import

import 'package:flutter/material.dart';
import 'CategoriesWidget2.dart';
import 'ItemPage.dart';
import 'package:grapeful/category.dart';
import 'package:grapeful/product.dart';

class CategoryProductWidget extends StatelessWidget {
  final int index;
  const CategoryProductWidget({Key? key, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text('Category'),
            backgroundColor: Color(0xFF00A368),
          ),
          body: FutureBuilder(
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
                      itemCount:
                          snapshot.data.length, //list data inside snapshot
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
                                      child:
                                          Text(snapshot.data[index].quantity[0],
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
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
                return CircularProgressIndicator();
              }),
        ),
        debugShowCheckedModeBanner: false);
  }
}

Future<List<Datum>> gettingCategoryData() async {
  var url = "https://grapeful-api.onrender.com/src/category/";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print("Data Found");
    CategoryClass dataModel = categoryClassFromMap(response.body);
    //print(dataModel.support.url);
    List<Datum> arrData = dataModel.data;
    print(arrData);
    //print(arrData[0].name); //fetching data from json for testing
    return arrData;
  } else {
    print("Something went wrong");
    throw Exception("Failed to Fetch");
  }
}

Future<List<Datum>> gettingProductData() async {
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
    print("Something went wrong");
    throw Exception("Failed to Fetch");
  }
}
