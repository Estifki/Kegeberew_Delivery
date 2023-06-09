// To parse this JSON data, do
//
//     final canceledModel = canceledModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CanceledModel canceledModelFromJson(String str) =>
    CanceledModel.fromJson(json.decode(str));

String canceledModelToJson(CanceledModel data) => json.encode(data.toJson());

class CanceledModel {
  String message;
  List<CanceledOrderData> data;

  CanceledModel({
    required this.message,
    required this.data,
  });

  factory CanceledModel.fromJson(Map<String, dynamic> json) => CanceledModel(
        message: json["message"],
        data: List<CanceledOrderData>.from(
            json["data"].map((x) => CanceledOrderData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CanceledOrderData {
  String id;
  Order order;
  String user;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CanceledOrderData({
    required this.id,
    required this.order,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CanceledOrderData.fromJson(Map<String, dynamic> json) =>
      CanceledOrderData(
        id: json["_id"],
        order: Order.fromJson(json["order"]),
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "order": order.toJson(),
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Order {
  String id;
  String user;
  bool inMainWareHouse;
  String phoneNo;
  List<Product> products;
  int totalPrice;
  Address address;
  String deliveryTime;
  String status;
  dynamic deliveryMan;
  String shippingType;
  String paymentMethod;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  dynamic branch;

  Order({
    required this.id,
    required this.user,
    required this.inMainWareHouse,
    required this.phoneNo,
    required this.products,
    required this.totalPrice,
    required this.address,
    required this.deliveryTime,
    required this.status,
    required this.deliveryMan,
    required this.shippingType,
    required this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.branch,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
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
        deliveryMan: json["deliveryMan"],
        shippingType: json["shippingType"],
        paymentMethod: json["paymentMethod"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        branch: json["branch"],
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
        "deliveryMan": deliveryMan,
        "shippingType": shippingType,
        "paymentMethod": paymentMethod,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "branch": branch,
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
