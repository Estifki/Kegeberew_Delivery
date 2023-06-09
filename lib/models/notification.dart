// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    String message;
    List<NotificationData> data;
    int count;

    NotificationModel({
        required this.message,
        required this.data,
        required this.count,
    });

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        message: json["message"],
        data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "count": count,
    };
}

class NotificationData {
    String id;
    String order;
    dynamic productRequest;
    String user;
    dynamic branch;
    bool isAdminNotification;
    String title;
    String message;
    dynamic readAt;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    NotificationData({
        required this.id,
        required this.order,
        required this.productRequest,
        required this.user,
        required this.branch,
        required this.isAdminNotification,
        required this.title,
        required this.message,
        required this.readAt,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        id: json["_id"],
        order: json["order"],
        productRequest: json["productRequest"],
        user: json["user"],
        branch: json["branch"],
        isAdminNotification: json["isAdminNotification"],
        title: json["title"],
        message: json["message"],
        readAt: json["readAt"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "order": order,
        "productRequest": productRequest,
        "user": user,
        "branch": branch,
        "isAdminNotification": isAdminNotification,
        "title": title,
        "message": message,
        "readAt": readAt,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
