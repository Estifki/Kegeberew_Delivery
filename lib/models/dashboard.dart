// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    String message;
    DashboardData data;

    DashboardModel({
        required this.message,
        required this.data,
    });

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        message: json["message"],
        data: DashboardData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class DashboardData {
    int completedOrders;
    int pendingOrders;
    int ongoingOrders;
    int canceledOrders;

    DashboardData({
        required this.completedOrders,
        required this.pendingOrders,
        required this.ongoingOrders,
        required this.canceledOrders,
    });

    factory DashboardData.fromJson(Map<String, dynamic> json) => DashboardData(
        completedOrders: json["completedOrders"],
        pendingOrders: json["pendingOrders"],
        ongoingOrders: json["ongoingOrders"],
        canceledOrders: json["canceledOrders"],
    );

    Map<String, dynamic> toJson() => {
        "completedOrders": completedOrders,
        "pendingOrders": pendingOrders,
        "ongoingOrders": ongoingOrders,
        "canceledOrders": canceledOrders,
    };
}
