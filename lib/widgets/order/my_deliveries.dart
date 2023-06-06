import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kegeberew_delivery/widgets/order/details.dart';

import '../../models/order.dart';

class MyDeliveriesWidget extends StatelessWidget {
  final OrderData orderData;
  final Color color;
  MyDeliveriesWidget({required this.orderData, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(orderCode: orderData.id),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Container(
          height: 130,
          width: MediaQuery.of(context).size.width * 0.92,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Stack(alignment: Alignment.centerLeft, children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Order Code"),
                  SizedBox(height: 1),
                  Text(
                    orderData.id,
                    style: TextStyle(color: color),
                  ),
                  SizedBox(height: 10),
                  Text(DateFormat('MMMM dd, yyyy')
                      .format(DateTime.parse(orderData.createdAt.toString()))),
                  SizedBox(height: 10),
                  Text("Payment Status"),
                  SizedBox(height: 1),
                  Text(orderData.paymentMethod),
                ],
              ),
              Positioned(
                  right: 15.0,
                  child: Text(
                    "br ${orderData.totalPrice.toString()}",
                    style: TextStyle(color: color),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
