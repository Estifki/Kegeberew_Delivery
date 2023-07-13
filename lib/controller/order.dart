import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/const.dart';
import '../models/order/canceled.dart';
import '../models/order/order.dart';
import '../models/order/order_details.dart';

class OrderProvider with ChangeNotifier {
  List<OrderData> _pendingData = [];
  List<OrderData> get pendingData => [..._pendingData];

  List<CanceledOrderData> _canceledData = [];
  List<CanceledOrderData> get canceledData => [..._canceledData];

  List<OrderData> _onTheWayData = [];
  List<OrderData> get onTheWayData => [..._onTheWayData];

  List<OrderData> _deliveredData = [];
  List<OrderData> get deliveredData => [..._deliveredData];

  List<OrderDetailsModel> _detailsData = [];
  List<OrderDetailsModel> get detailsData => [..._detailsData];

  void clearOrders() {
    _pendingData.clear();
    _onTheWayData.clear();
    _deliveredData.clear();
    _canceledData.clear();
  }

  Future getPending({required userID}) async {
    String url = "${AppConst.baseurl}/delivery/pending/$userID";

    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _pendingData.clear();
        final data = orderModelFromJson(response.body);
        print("Data ${data.data.length}");
        _pendingData.addAll(data.data);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future getCanceled({required userID}) async {
    String url = "${AppConst.baseurl}/delivery/canceled/$userID";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _canceledData.clear();
        final data = canceledModelFromJson(response.body);

        _canceledData.addAll(data.data);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future getOnTheWay({required userID}) async {
    String url = "${AppConst.baseurl}/delivery/on-the-way/$userID";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _onTheWayData.clear();
        final data = orderModelFromJson(response.body);
        _onTheWayData.addAll(data.data);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future getDelivered({required userID}) async {
    String url = "${AppConst.baseurl}/delivery/delivered/$userID";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _deliveredData.clear();
        final data = orderModelFromJson(response.body);
        _deliveredData.addAll(data.data);
        notifyListeners();
      }
    } catch (_) {}
  }

  Future getOrderDetails({required orderID}) async {
    String url = "${AppConst.baseurl}/delivery/order-detail/$orderID";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _detailsData.clear();
        final data = orderDetailsModelFromJson(response.body);
        _detailsData.add(data);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future acceptOrder({required orderID, required userID}) async {
    String url = "${AppConst.baseurl}/delivery/accept/$userID";

    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"order": orderID}));

      print(response.body);

      print(response.statusCode);
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        getPending(userID: userID);
        getOnTheWay(userID: userID);
      }
    } catch (_) {
      rethrow;
    }
  }

  Future cancelOrder({required orderID, required userID}) async {
    String url = "${AppConst.baseurl}/delivery/cancel/$userID";

    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"order": orderID}));

      print(response.body);

      print(response.statusCode);
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        getPending(userID: userID);
        getOnTheWay(userID: userID);
        notifyListeners();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future markAsDeliveredOrder({required orderID, required userID}) async {
    String url = "${AppConst.baseurl}/delivery/delivered/$userID";

    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"order": orderID}));

      print(response.body);

      print(response.statusCode);
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        getOnTheWay(userID: userID);
        getDelivered(userID: userID);
        notifyListeners();
      }
    } catch (_) {
      rethrow;
    }
  }
}
