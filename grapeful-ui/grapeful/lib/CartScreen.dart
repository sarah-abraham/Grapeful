// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, unnecessary_null_comparison, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grapeful/cart_controller.dart';
import 'package:grapeful/cart_total.dart';
import 'package:grapeful/product.dart';

int flag = 0;

class CartScreen extends StatelessWidget {
  final CartController controller = Get.find();
  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Shopping Cart'),
            centerTitle: true,
            backgroundColor: Color(0xFF00A368)),
        body: SizedBox(
            height: 600,
            child: Obx(() => ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CartProductCard(
                        controller: controller,
                        product: controller.products.keys.toList()[index],
                        quantity: controller.products.values.toList()[index],
                        index: index);

                    return Text("No Item in cart");
                  },
                ))),
        bottomNavigationBar: CartTotal());
  }
}

class CartProductCard extends StatelessWidget {
  final CartController controller;
  final List<Datum> product;
  final int quantity;
  final int index;

  const CartProductCard({
    Key? key,
    required this.controller,
    required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    flag = 1;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // CircleAvatar(
              //     radius: 40,
              //     backgroundImage: NetworkImage(product[0].images[0])),
              Container(
                margin: EdgeInsets.all(10),
                child: product[0].images[0] == null
                    ? Image(
                        image: AssetImage('images/no_image_available.png'),
                      )
                    : Image.network('${product[0].images[0]}'),
                height: 90,
                width: 90,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(product[0].title),
              ),
              IconButton(
                onPressed: () {
                  controller.removeProduct(product);
                },
                icon: Icon(Icons.remove_circle),
              ),
              Text('${quantity}'),
              IconButton(
                onPressed: () {
                  controller.addProduct(product);
                },
                icon: Icon(Icons.add_circle),
              ),
            ],
          ),
          SizedBox(height: 10),
        ]));
  }
}
