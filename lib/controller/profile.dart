import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constant/const.dart';
import '../models/profile.dart';

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
}
