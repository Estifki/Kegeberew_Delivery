import 'package:flutter/material.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
            height: 100,
            width: 100,
            // margin: EdgeInsets.only(bottom: haveScaffold ? 46 : 0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Center(
                child: Transform.scale(
                    scale: 0.8,
                    child:
                        const CircularProgressIndicator(color: Colors.red)))));
  }
}
