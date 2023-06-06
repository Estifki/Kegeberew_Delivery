// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  String message;
  Data data;
  Location location;

  OrderDetailsModel({
    required this.message,
    required this.data,
    required this.location,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "location": location.toJson(),
      };
}

class Data {
  String id;
  User user;
  bool inMainWareHouse;
  String phoneNo;
  List<ProductElement> products;
  dynamic totalPrice;
  Address address;
  String deliveryTime;
  String status;
  String deliveryMan;
  String shippingType;
  String paymentMethod;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic v;

  Data({
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
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        user: User.fromJson(json["user"]),
        inMainWareHouse: json["inMainWareHouse"],
        phoneNo: json["phoneNo"],
        products: List<ProductElement>.from(
            json["products"].map((x) => ProductElement.fromJson(x))),
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
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "user": user.toJson(),
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
      };
}

class Address {
  List<double> location;
  String address;
  String id;
  dynamic phone;

  Address({
    required this.location,
    required this.address,
    required this.id,
    required this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        address: json["address"],
        id: json["_id"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "location": List<dynamic>.from(location.map((x) => x)),
        "address": address,
        "_id": id,
        "phone": phone,
      };
}

class ProductElement {
  ProductProduct product;
  dynamic quantity;
  String id;

  ProductElement({
    required this.product,
    required this.quantity,
    required this.id,
  });

  factory ProductElement.fromJson(Map<String, dynamic> json) => ProductElement(
        product: ProductProduct.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "_id": id,
      };
}

class ProductProduct {
  String id;
  String category;
  String name;
  String nameAm;
  List<String> image;
  String description;
  String descriptionAm;
  dynamic price;
  String priceType;
  bool hasSpecialOffer;
  bool isTodaysPick;
  bool isOutOfStock;
  dynamic view;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic v;

  ProductProduct({
    required this.id,
    required this.category,
    required this.name,
    required this.nameAm,
    required this.image,
    required this.description,
    required this.descriptionAm,
    required this.price,
    required this.priceType,
    required this.hasSpecialOffer,
    required this.isTodaysPick,
    required this.isOutOfStock,
    required this.view,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory ProductProduct.fromJson(Map<String, dynamic> json) => ProductProduct(
        id: json["_id"],
        category: json["category"],
        name: json["name"],
        nameAm: json["nameAm"],
        image: List<String>.from(json["image"].map((x) => x)),
        description: json["description"],
        descriptionAm: json["descriptionAm"],
        price: json["price"],
        priceType: json["priceType"],
        hasSpecialOffer: json["hasSpecialOffer"],
        isTodaysPick: json["isTodaysPick"],
        isOutOfStock: json["isOutOfStock"],
        view: json["view"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "name": name,
        "nameAm": nameAm,
        "image": List<dynamic>.from(image.map((x) => x)),
        "description": description,
        "descriptionAm": descriptionAm,
        "price": price,
        "priceType": priceType,
        "hasSpecialOffer": hasSpecialOffer,
        "isTodaysPick": isTodaysPick,
        "isOutOfStock": isOutOfStock,
        "view": view,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class User {
  String id;
  dynamic phone;
  String firstName;
  String lastName;
  String email;
  String password;
  String profile;
  List<Address> address;
  bool otpVerified;
  bool isRegistered;
  bool isAccountHidden;
  String role;
  dynamic branch;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic v;

  User({
    required this.id,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.profile,
    required this.address,
    required this.otpVerified,
    required this.isRegistered,
    required this.isAccountHidden,
    required this.role,
    required this.branch,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        phone: json["phone"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        profile: json["profile"],
        address:
            List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
        otpVerified: json["otpVerified"],
        isRegistered: json["isRegistered"],
        isAccountHidden: json["isAccountHidden"],
        role: json["role"],
        branch: json["branch"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phone": phone,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "profile": profile,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "otpVerified": otpVerified,
        "isRegistered": isRegistered,
        "isAccountHidden": isAccountHidden,
        "role": role,
        "branch": branch,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
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
