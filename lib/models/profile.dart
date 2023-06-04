// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  dynamic message;
  UserData data;

  ProfileModel({
    required this.message,
    required this.data,
  });

  factory ProfileModel.fromJson(Map<dynamic, dynamic> json) => ProfileModel(
        message: json["message"],
        data: UserData.fromJson(json["data"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
      };
}

class UserData {
  Profile profile;
  dynamic orders;
  dynamic favorites;
  dynamic deliveredOrders;

  UserData({
    required this.profile,
    required this.orders,
    required this.favorites,
    required this.deliveredOrders,
  });

  factory UserData.fromJson(Map<dynamic, dynamic> json) => UserData(
        profile: Profile.fromJson(json["profile"]),
        orders: json["orders"],
        favorites: json["favorites"],
        deliveredOrders: json["deliveredOrders"],
      );

  Map<dynamic, dynamic> toJson() => {
        "profile": profile.toJson(),
        "orders": orders,
        "favorites": favorites,
        "deliveredOrders": deliveredOrders,
      };
}

class Profile {
  dynamic id;
  dynamic firstName;
  dynamic lastName;
  dynamic profile;
  dynamic email;
  dynamic phone;
  List<UserAddress> address;
  DateTime createdAt;
  DateTime updatedAt;

  Profile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profile,
    required this.email,
    required this.phone,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Profile.fromJson(Map<dynamic, dynamic> json) => Profile(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        profile: json["profile"],
        email: json["email"],
        phone: json["phone"],
        address: List<UserAddress>.from(
            json["address"].map((x) => UserAddress.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "profile": profile,
        "email": email,
        "phone": phone,
        "address": List<dynamic>.from(address.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class UserAddress {
  List<dynamic> location;
  dynamic address;
  dynamic id;
  dynamic phone;

  UserAddress({
    required this.location,
    required this.address,
    required this.id,
    required this.phone,
  });

  factory UserAddress.fromJson(Map<dynamic, dynamic> json) => UserAddress(
        location: List<double>.from(json["location"].map((x) => x?.toDouble())),
        address: json["address"],
        id: json["_id"],
        phone: json["phone"],
      );

  Map<dynamic, dynamic> toJson() => {
        "location": List<dynamic>.from(location.map((x) => x)),
        "address": address,
        "_id": id,
        "phone": phone,
      };
}
