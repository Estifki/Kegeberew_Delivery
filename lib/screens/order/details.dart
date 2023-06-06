import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kegeberew_delivery/controller/order.dart';
import 'package:provider/provider.dart';

import '../../controller/auth.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderCode;
  OrderDetailsScreen({required this.orderCode});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future _detailsData;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _detailsData = Provider.of<OrderProvider>(context, listen: false)
          .getOrderDetails(orderID: widget.orderCode);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Details"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _detailsData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text("ERror"));
            } else {
              return Consumer<OrderProvider>(builder: (context, value, _) {
                print(value.detailsData);
                if (value.detailsData.isEmpty) {
                  return Center(child: Text("No Data"));
                }
                return SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    //
                    //Order Info
                    //
                    Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        height: 270,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailsRowWidget(
                                    title1: "Order Code",
                                    value1: widget.orderCode,
                                    title2: "Payment Method",
                                    value2:
                                        value.detailsData[0].data.paymentMethod,
                                    color: Colors.red),
                                SizedBox(height: 20),
                                DetailsRowWidget(
                                    title1: "Order Date",
                                    value1: "may-21-2023",
                                    title2: "Delivery status",
                                    value2: value.detailsData[0].data.status),
                                SizedBox(height: 20),
                                DetailsRowWidget(
                                    title1: "Shipping Type",
                                    value1:
                                        value.detailsData[0].data.shippingType,
                                    title2: "Total Price",
                                    value2:
                                        "Br ${value.detailsData[0].data.totalPrice.toString()}"),
                                SizedBox(height: 20),
                                Text("Shippment Address"),
                                SizedBox(height: 5),
                                Text(
                                    "Name: ${value.detailsData[0].data.user.email}"),
                                SizedBox(height: 3),
                                Text(
                                    "Phone: ${value.detailsData[0].data.phoneNo}"),
                                SizedBox(height: 3),
                                Text(
                                    "email: ${value.detailsData[0].data.user.email}"),
                              ]),
                        ),
                      ),
                    ),
                    //
                    //Accept Or Cancele Order
                    //
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 42,
                            width: MediaQuery.of(context).size.width * 0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text("Accept Order"),
                          ),
                          Container(
                            height: 42,
                            width: MediaQuery.of(context).size.width * 0.4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text("Cancel Order"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Center(child: Text("Ordered Products")),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 20, bottom: 20),
                          itemCount: value.detailsData[0].data.products.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(value.detailsData[0].data.products[index]
                                    .product.name)
                              ],
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ));
              });
            }
          }
        },
      ),
    );
  }
}

class DetailsRowWidget extends StatelessWidget {
  final String title1;
  final String value1;
  final String title2;
  final String value2;
  final Color color;

  DetailsRowWidget(
      {required this.title1,
      required this.value1,
      required this.title2,
      required this.value2,
      this.color = Colors.grey});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1),
            SizedBox(height: 3),
            Text(
              value1,
              style: TextStyle(color: color),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title2),
            SizedBox(height: 3),
            Text(value2),
          ],
        ),
      ],
    );
  }
}
