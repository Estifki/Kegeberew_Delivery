import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/const.dart';
import '../models/profile.dart';
import '../util/custom_exception.dart';

class ProfileProvider with ChangeNotifier {
  final List<UserData> _userData = [];

  List<UserData> get userData => [..._userData];

  void clearProfile() {
    _userData.clear();
  }

  Future getProfile({required String userID}) async {
    String url = "${AppConst.baseurl}/user/profile/$userID";
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode != 200) {
        //
        //
        //
      } else {
        final data = profileModelFromJson(response.body);
        _userData.clear();
        _userData.addAll([data.data]);
        notifyListeners();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future updatePassword(
      {required userID, required oldPassword, required newPassword}) async {
    String url = "${AppConst.baseurl}/user/change-password/$userID";

    try {
      http.Response response = await http.put(Uri.parse(url),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "old_password": oldPassword,
            "new_password": newPassword,
          }));
      final decodedData = jsonDecode(response.body);
      if (response.statusCode != 200) {
        throw CustomException(errorMessage: decodedData["message"]);
      } else {
        getProfile(userID: userID);
      }
    } catch (_) {
      rethrow;
    }
  }
}
