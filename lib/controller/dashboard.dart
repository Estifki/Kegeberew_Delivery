import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kegeberew_delivery/constant/const.dart';
import 'package:kegeberew_delivery/models/dashboard.dart';

class DashboardProvider with ChangeNotifier {
  List<DashboardData> _dashboardData = [];
  List<DashboardData> get dashboardData => [..._dashboardData];

  void clearDashboard() {
    _dashboardData.clear();
  }

  Future getDashbord({required userID}) async {
    String url = "${AppConst.baseurl}/delivery/dashboard/$userID";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        _dashboardData.clear();
        final data = dashboardModelFromJson(response.body);
        _dashboardData.addAll([data.data]);
        notifyListeners();
      }
    } catch (_) {}
  }
}
