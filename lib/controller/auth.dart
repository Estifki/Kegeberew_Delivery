import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kegeberew_delivery/util/custom_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/const.dart';

class AuthProvider with ChangeNotifier {
  String? userID;
  String? token;
  Future<bool> getLoginStatus() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userID") != null) {
      userID = prefs.getString("userID");
      token = prefs.getString("token");
      notifyListeners();
      return true;
    } else {
      userID = null;
      token = null;
      notifyListeners();
      return false;
    }
  }

  Future signIn({required int phone, required String password}) async {
    var url = "${AppConst.baseurl}/auth/delivery/sign-in";
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone": phone, "password": password}),
      );

      var decodedData = jsonDecode(response.body);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode != 200) {
        throw CustomException(errorMessage: decodedData["message"]);
      } else {
        var prefs = await SharedPreferences.getInstance();
        prefs.setString("userID", decodedData["user"]["_id"]);
        prefs.setString("token", decodedData["token"]);

        userID = prefs.getString("userID");
        token = prefs.getString("token");

        // notifyListeners();
      }
    } catch (_) {
      rethrow;
    }
  }

  signOut() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("userID");
    userID = null;
    token = null;
  }
}
