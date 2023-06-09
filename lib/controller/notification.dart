// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kegeberew_delivery/util/custom_exception.dart';

import '../constant/const.dart';
import '../models/notification.dart';

class NotificationProvider with ChangeNotifier {
  final List<NotificationData> _notificationData = [];
  List<NotificationData> get notificationData => [..._notificationData];
  int _newNotification = 0;
  int get newNotification => _newNotification;
  Future getNotification(BuildContext context, String userID) async {
    var url = "${AppConst.baseurl}/notification/find/$userID";
    try {
      http.Response response = await http.get(Uri.parse(url));
      var decodedData = jsonDecode(response.body);

      if (response.statusCode != 200) {
        throw CustomException(errorMessage: decodedData["message"]);
      } else {
        var data = notificationModelFromJson(response.body);
        _notificationData.clear();
        _newNotification = data.count;
        _notificationData.addAll(data.data);
        notifyListeners();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future markAllAsRead(BuildContext context, String userID) async {
    String url = "${AppConst.baseurl}/notification/read-all/$userID";
    try {
      http.Response response = await http.put(Uri.parse(url));
      var decodedData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw CustomException(errorMessage: decodedData["message"]);
      } else {
        await getNotification(context, userID);
      }
    } catch (e) {
      rethrow;
    }
  }
}
