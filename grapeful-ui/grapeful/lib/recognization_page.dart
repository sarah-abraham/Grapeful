// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:grapeful/product.dart';

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
    return Scaffold(
        appBar: AppBar(title: const Text("recognized page")),
        body: _isBusy == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: MediaQuery.of(context).size.height.toInt(),
                  controller: controller,
                  decoration:
                      const InputDecoration(hintText: "Text goes here..."),
                ),
              ));
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
      print(items.length);
      gettingData(items[i]);
    }
    print(items);

    controller.text = recognizedText.text;

    Future<List<Datum>> snapshot = gettingData(recognizedText.text);
    print(snapshot);
    // cartController.addProduct(snapshot.data);
    // FutureBuilder(
    //     future: gettingData(recognizedText.text),
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //       cartController.addProduct(snapshot);
    //       return Text("Error");
    //     });

    ///End busy state
    setState(() {
      _isBusy = false;
    });
  }
}

Future<List<Datum>> gettingData(String product) async {
  var url = "https://grapeful-api.onrender.com/src/productTitle/" + product;
  var response = await http.get(Uri.parse(url));
  final cartController = Get.put(CartController());
  if (response.statusCode == 200) {
    // ignore: avoid_print
    print("Data Found");
    ProductClass dataModel = productClassFromMap(response.body);
    //print(dataModel.support.url);
    List<Datum> arrData = dataModel.data;
    print(arrData);
    cartController.addProduct(arrData);
    //print(arrData[0].name); //fetching data from json for testing
    return arrData;
  } else {
    throw Exception("Failed to Fetch");
  }
}
