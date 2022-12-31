// To parse this JSON data, do
//
//     final productClass = productClassFromMap(jsonString);

import 'dart:convert';

CategoryClass categoryClassFromMap(String str) =>
    CategoryClass.fromMap(json.decode(str));

String categoryClassToMap(CategoryClass data) => json.encode(data.toMap());

class CategoryClass {
  CategoryClass({
    required this.data,
  });

  List<Datum> data;

  factory CategoryClass.fromMap(Map<String, dynamic> json) => CategoryClass(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.categoryid,
    required this.title,
    required this.images,
    // required this.addedon,
    // required this.v,
  });

  String id;
  String categoryid;
  String title;
  List<String> images;
  // Addedon addedon;
  // V v;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        categoryid: json["categoryid"],
        title: json["title"],
        images: List<String>.from(json["images"].map((x) => x)),
        // addedon: Addedon.fromMap(json["addedon"]),
        // v: V.fromMap(json["__v"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "categoryid": categoryid,
        "title": title,
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
