import 'package:flutter/material.dart';

class AppConst {
  static const String baseurl = "https://grocery.up.railway.app/api";


   Widget customLoadingIndicator() {
    return Center(
      child: Container(
        height: 74,
        width: 220,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Transform.scale(
                  scale: 0.8, child: const CircularProgressIndicator()),
              const Text(
                "Please Wait ...",
                style: TextStyle(color: Colors.black),
              ),
              const Text(""),
            ]),
      ),
    );
  }
}
