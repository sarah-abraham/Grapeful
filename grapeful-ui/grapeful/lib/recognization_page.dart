// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:grapeful/CartScreen.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:grapeful/product.dart';

import 'HomePage2.dart';
import 'cart_controller.dart';

class RecognizePage extends StatefulWidget {
  final String? path;
  const RecognizePage({Key? key, this.path}) : super(key: key);

  @override
  State<RecognizePage> createState() => _RecognizePageState();
}

class _RecognizePageState extends State<RecognizePage> {
  bool _isBusy = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    final InputImage inputImage = InputImage.fromFilePath(widget.path!);

    processImage(inputImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CartScreen());
    // appBar: AppBar(title: const Text("recognized page")),
    // body: _isBusy == true
    //     ? const Center(
    //         child: CircularProgressIndicator(),
    //       )
    //     : Container(
    //         padding: const EdgeInsets.all(20),
    //         child: TextFormField(
    //           maxLines: MediaQuery.of(context).size.height.toInt(),
    //           controller: controller,
    //           decoration:
    //               const InputDecoration(hintText: "Text goes here..."),
    //         ),
    //       ));
  }

  void processImage(InputImage image) async {
    final cartController = Get.put(CartController());
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    setState(() {
      _isBusy = true;
    });

    log(image.filePath!);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(image);

    String itemstext = recognizedText.text;
    LineSplitter ls = new LineSplitter();
    print(recognizedText.text);

    var items = ls.convert(itemstext);

    for (int i = 0; i <= items.length; i++) {
      print(items[i]);
      allData(items[i]);
    }

    controller.text = recognizedText.text;

    ///End busy state
    setState(() {
      _isBusy = false;
    });
  }
}

Future<List<Datum>> allData(String value) async {
  final cartController = Get.put(CartController());
  List<Datum> arrData1 = [];
  List<String> productTitleAdded = [];
  var url = "https://grapeful-api.onrender.com/src/productTitle/";
  var response = await http.get(Uri.parse(url));
  List<int> found_index = [];
  if (response.statusCode == 200) {
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
        print(productTitle);
        print("-------------------------------------------------");
        found_index.add(i);
      }
    }
  }
  for (int j = 0; j < productTitleAdded.length; j++) {
    var product_url = "https://grapeful-api.onrender.com/src/productTitle/" +
        productTitleAdded[j];
    var response = await http.get(Uri.parse(product_url));
    if (response.statusCode == 200) {
      // ignore: avoid_print
      print("Data Found");
      ProductClass dataModel = productClassFromMap(response.body);

      List<Datum> arrData1 = dataModel.data;
      print(arrData1);
      //print(arrData[0].name); //fetching data from json for testing
      cartController.addProduct(arrData1);
      return arrData1;
    } else {
      throw Exception("Failed to Fetch");
    }
  }
  return arrData1;
}
