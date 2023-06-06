import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderCode;
  OrderDetailsScreen({required this.orderCode});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Container(
              height: 400,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          )
        ],
      )),
    );
  }
}
