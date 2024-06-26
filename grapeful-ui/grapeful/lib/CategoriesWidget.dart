// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:grapeful/CategoryProductWidget.dart';
import 'package:grapeful/category.dart';
import 'package:http/http.dart' as http;

class CategoriesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Category",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF116530),
              ),
            ),
          ],
        ),
      ),
      SingleChildScrollView(
          //so we can scroll row in the horizontal direction
          scrollDirection: Axis.horizontal,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            for (int index = 0; index <= 5; index++)
              FutureBuilder(
                  future: gettingCategoryData(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => CategoryProductWidget(
                                      index: index,
                                    )));
                          },
                          child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              width: 160,
                              height: 240,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.all(5),
                                  child: snapshot.data[index].images[0] == null
                                      ? Image(
                                          image: AssetImage(
                                              'images/no_image_available.png'),
                                        )
                                      : Image.network(
                                          '${snapshot.data[index].images[0]}',
                                          height: 150,
                                          width: 150),
                                  // height: 50,
                                  // width: 50,
                                ),
                                Center(
                                    child: Padding(
                                  padding: EdgeInsets.only(right: 25, left: 25),
                                  child: Text(snapshot.data[index].title,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                ))
                              ])));
                    }

                    return SizedBox();
                  })
          ]))
    ]);
  }
}

Future<List<CData>> gettingCategoryData() async {
  var url = "https://grapeful-api.onrender.com/src/category/";
  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print("Data Found");
    CategoryClass dataModel = categoryClassFromMap(response.body);
    //print(dataModel.support.url);
    List<CData> arrData = dataModel.data;
    print(arrData);
    //print(arrData[0].name); //fetching data from json for testing
    return arrData;
  } else {
    print("Something went wrong");
    throw Exception("Failed to Fetch");
  }
}
