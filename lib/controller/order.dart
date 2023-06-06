import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kegeberew_delivery/constant/const.dart';
import 'package:kegeberew_delivery/models/order.dart';
import 'package:kegeberew_delivery/models/order_details.dart';

class OrderProvider with ChangeNotifier {
  List<OrderData> _pendingData = [];
  List<OrderData> get pendingData => [..._pendingData];

  List<OrderData> _canceledData = [];
  List<OrderData> get canceledData => [..._canceledData];

  List<OrderData> _onTheWayData = [];
  List<OrderData> get onTheWayData => [..._onTheWayData];

  List<OrderData> _deliveredData = [];
  List<OrderData> get deliveredData => [..._deliveredData];

  List<OrderDetailsModel> _detailsData = [];
  List<OrderDetailsModel> get detailsData => [..._detailsData];

  Future getPending({required userID}) async {
    String url = "${AppConst.baseurl}/delivery/pending/$userID";

    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _pendingData.clear();
        final data = orderModelFromJson(response.body);
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
        final data = orderModelFromJson(response.body);
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
}
