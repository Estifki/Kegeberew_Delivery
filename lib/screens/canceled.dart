import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/auth.dart';
import '../controller/order.dart';
import '../widgets/order/my_deliveries.dart';
import 'order/details.dart';

class CanceledDeliveriesScreen extends StatefulWidget {
  const CanceledDeliveriesScreen({super.key});

  @override
  State<CanceledDeliveriesScreen> createState() =>
      _CanceledDeliveriesScreenState();
}

class _CanceledDeliveriesScreenState extends State<CanceledDeliveriesScreen> {
  bool _isinit = true;
  late Future _canceledDeliveries;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      _canceledDeliveries = Provider.of<OrderProvider>(context, listen: false)
          .getCanceled(
              userID:
                  Provider.of<AuthProvider>(context, listen: false).userID!);
      _isinit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        centerTitle: true,
        title: Text("Canceled Delivery"),
      ),
      body: FutureBuilder(
          future: _canceledDeliveries,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else {
              if (snapshot.hasError) {
                return Center(child: Text("Error"));
              } else {
                return Consumer<OrderProvider>(builder: (context, value, _) {
                  if (value.canceledData.isEmpty) {
                    return Center(child: Text("No Canceled Delivery"));
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.canceledData.length,
                      padding: EdgeInsets.only(top: 15),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigator.of(context).push(MaterialPageRoute(
                            //   builder: (context) => OrderDetailsScreen(
                            //       orderCode:
                            //           value.canceledData[index].order.id),
                            // ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            child: Container(
                              height: 130,
                              width: MediaQuery.of(context).size.width * 0.92,
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 15),
                                child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Order Code"),
                                          SizedBox(height: 1),
                                          Text(
                                            value.canceledData[index].id,
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          SizedBox(height: 10),
                                          Text(DateFormat('MMMM dd, yyyy')
                                              .format(DateTime.parse(value
                                                  .canceledData[index].createdAt
                                                  .toString()))),
                                          SizedBox(height: 10),
                                          Text("Payment Status"),
                                          SizedBox(height: 1),
                                          Text(value.canceledData[index].order
                                              .paymentMethod),
                                        ],
                                      ),
                                      Positioned(
                                          right: 15.0,
                                          child: Text(
                                            "Br ${((value.canceledData[index].order.totalPrice * 0.25) + value.canceledData[index].order.totalPrice).toString()}",
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ]),
                              ),
                            ),
                          ),
                        );
                      });
                });
              }
            }
          }),
    );
  }
}
