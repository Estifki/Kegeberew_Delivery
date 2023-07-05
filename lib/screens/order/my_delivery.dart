import 'package:flutter/material.dart';
import '../../controller/order.dart';
import 'package:provider/provider.dart';

import '../../controller/auth.dart';
import '../../widgets/order/my_deliveries.dart';

class MyDeliveryScreen extends StatefulWidget {
  @override
  State<MyDeliveryScreen> createState() => _MyDeliveryScreenState();
}

class _MyDeliveryScreenState extends State<MyDeliveryScreen> {
  bool _isinit = true;
  late Future _myDeliveries;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      _myDeliveries = Provider.of<OrderProvider>(context, listen: false)
          .getPending(
              userID:
                  Provider.of<AuthProvider>(context, listen: false).userID!);
      Provider.of<OrderProvider>(context, listen: false).getOnTheWay(
          userID: Provider.of<AuthProvider>(context, listen: false).userID!);
      Provider.of<OrderProvider>(context, listen: false).getDelivered(
          userID: Provider.of<AuthProvider>(context, listen: false).userID!);
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<OrderProvider>(context, listen: false).getPending(
        userID: Provider.of<AuthProvider>(context, listen: false).userID!);
    Provider.of<OrderProvider>(context, listen: false).getOnTheWay(
        userID: Provider.of<AuthProvider>(context, listen: false).userID!);
    Provider.of<OrderProvider>(context, listen: false).getDelivered(
        userID: Provider.of<AuthProvider>(context, listen: false).userID!);
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 10.0,
            bottom: TabBar(
                indicatorPadding: EdgeInsets.only(left: 25, right: 25),
                tabs: [
                  Tab(text: "Pending"),
                  Tab(text: "On The way"),
                  Tab(text: "Delivered"),
                ]),
          ),
          body: TabBarView(children: [
            FutureBuilder(
              future: _myDeliveries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  } else {
                    return Consumer<OrderProvider>(
                      builder: (context, value, _) {
                        if (value.pendingData.isEmpty) {
                          return Center(child: Text("No Pending Delivery"));
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: value.pendingData.length,
                          padding: EdgeInsets.only(top: 15),
                          itemBuilder: (context, index) {
                            return MyDeliveriesWidget(
                                orderData: value.pendingData[index],
                                color: Colors.yellow);
                          },
                        );
                      },
                    );
                  }
                }
              },
            ),
            //
            //On The way
            //

            Consumer<OrderProvider>(
              builder: (context, value, _) {
                if (value.onTheWayData.isEmpty) {
                  return Center(child: Text("No On The Way Delivery"));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.onTheWayData.length,
                  padding: EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    return MyDeliveriesWidget(
                        orderData: value.onTheWayData[index],
                        color: Colors.blue);
                  },
                );
              },
            ),

            //
            //On The way
            //
            Consumer<OrderProvider>(
              builder: (context, value, _) {
                if (value.deliveredData.isEmpty) {
                  return Center(
                      child: Text("Delivered Will Be Avaliable Here."));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.deliveredData.length,
                  padding: EdgeInsets.only(top: 15),
                  itemBuilder: (context, index) {
                    return MyDeliveriesWidget(
                        orderData: value.deliveredData[index],
                        color: Colors.green);
                  },
                );
              },
            ),
          ]),
        ));
  }
}







