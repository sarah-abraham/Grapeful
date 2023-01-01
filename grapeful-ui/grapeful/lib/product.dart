// To parse this JSON data, do
//
//     final productClass = productClassFromMap(jsonString);

import 'dart:convert';

ProductClass productClassFromMap(String str) =>
    ProductClass.fromMap(json.decode(str));

String productClassToMap(ProductClass data) => json.encode(data.toMap());

class ProductClass {
  ProductClass({
    required this.data,
  });

  List<Datum> data;

  factory ProductClass.fromMap(Map<String, dynamic> json) => ProductClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.productid,
    required this.title,
    required this.category,
    required this.description,
    required this.quantity,
    required this.price,
    required this.images,
    // required this.addedon,
    // required this.v,
  });

  String id;
  String productid;
  String title;
  String category;
  String description;
  List<String> quantity;
  int price;
  List<String> images;
  // Addedon addedon;
  // V v;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        productid: json["productid"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
        quantity: List<String>.from(json["quantity"].map((x) => x)),
        price: json["price"],
        images: List<String>.from(json["images"].map((x) => x)),
        // addedon: Addedon.fromMap(json["addedon"]),
        // v: V.fromMap(json["__v"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "productid": productid,
        "title": title,
        "category": category,
        "description": description,
        "quantity": List<dynamic>.from(quantity.map((x) => x)),
        "price": price,
        "images": List<dynamic>.from(images.map((x) => x)),
        // "addedon": addedon.toMap(),
        // "__v": v.toMap(),
      };
}

class Addedon {
  Addedon({
    required this.date,
  });

  Date date;

  factory Addedon.fromMap(Map<String, dynamic> json) => Addedon(
        date: Date.fromMap(json["\u0024date"]),
      );

  Map<String, dynamic> toMap() => {
        "\u0024date": date.toMap(),
      };
}

class Date {
  Date({
    required this.numberLong,
  });

  String numberLong;

  factory Date.fromMap(Map<String, dynamic> json) => Date(
        numberLong: json["\u0024numberLong"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024numberLong": numberLong,
      };
}

class Id {
  Id({
    required this.oid,
  });

  String oid;

  factory Id.fromMap(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024oid": oid,
      };
}

class V {
  V({
    required this.numberInt,
  });

  String numberInt;

  factory V.fromMap(Map<String, dynamic> json) => V(
        numberInt: json["\u0024numberInt"],
      );

  Map<String, dynamic> toMap() => {
        "\u0024numberInt": numberInt,
      };
}
