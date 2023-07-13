// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderModel orderModelFromJson(String str) =>
    OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String message;
  List<OrderData> data;

  OrderModel({
    required this.message,
    required this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        message: json["message"],
        data: List<OrderData>.from(
            json["data"].map((x) => OrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class OrderData {
  String id;
  String user;
  bool inMainWareHouse;
  String phoneNo;
  List<Product> products;
  dynamic totalPrice;
  Address address;
  String deliveryTime;
  String status;
  String shippingType;
  String paymentMethod;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String deliveryMan;
  Location location;

  OrderData({
    required this.id,
    required this.user,
    required this.inMainWareHouse,
    required this.phoneNo,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.deliveryTime,
    required this.status,
    required this.shippingType,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.deliveryMan,
    required this.location,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
        id: json["_id"],
        user: json["user"],
        inMainWareHouse: json["inMainWareHouse"],
        phoneNo: json["phoneNo"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        totalPrice: json["totalPrice"],
        address: Address.fromJson(json["address"]),
        deliveryTime: json["deliveryTime"],
        status: json["status"],
        shippingType: json["shippingType"],
        paymentMethod: json["paymentMethod"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        deliveryMan: json["deliveryMan"],
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user,
        "inMainWareHouse": inMainWareHouse,
        "phoneNo": phoneNo,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "totalPrice": totalPrice,
        "address": address.toJson(),
        "deliveryTime": deliveryTime,
        "status": status,
        "shippingType": shippingType,
        "paymentMethod": paymentMethod,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "deliveryMan": deliveryMan,
        "location": location.toJson(),
      };
}

class Address {
  List<double> location;
  String address;
  String id;

  Address({
    required this.location,
    required this.address,
    required this.id,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        address: json["address"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "location": List<dynamic>.from(location.map((x) => x)),
        "address": address,
        "_id": id,
      };
}

class Location {
  String type;
  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}

class Product {
  String product;
  int quantity;
  String id;

  Product({
    required this.product,
    required this.quantity,
    required this.id,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        product: json["product"],
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "_id": id,
      };
}
