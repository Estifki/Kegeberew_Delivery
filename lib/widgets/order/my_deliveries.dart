import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order/order.dart';
import '../../screens/order/details.dart';

class MyDeliveriesWidget extends StatelessWidget {
  final OrderData orderData;
  final Color color;
  MyDeliveriesWidget({required this.orderData, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(
                  orderCode: orderData.id,
                  sourceLat: orderData.location.coordinates[1],
                  sourceLong: orderData.location.coordinates[0],
                  destinationLat: orderData.address.location[1],
                  destinationLong: orderData.address.location[0],
                )));
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
                    "Br ${((orderData.totalPrice * 0.25) + orderData.totalPrice).toString()}",
                    style: TextStyle(color: color),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
