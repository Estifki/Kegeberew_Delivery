import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:kegeberew_delivery/constant/const.dart';
import 'package:kegeberew_delivery/controller/order.dart';
import 'package:kegeberew_delivery/util/toast.dart';
import 'package:provider/provider.dart';

import '../../controller/auth.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderCode;
  final double sourceLat;

  final double sourceLong;

  final double destinationLat;

  final double destinationLong;
  OrderDetailsScreen(
      {required this.orderCode,
      required this.sourceLat,
      required this.sourceLong,
      required this.destinationLat,
      required this.destinationLong});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late Future _detailsData;
  bool _isInit = true;

  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      getPolyPoints();
      _detailsData = Provider.of<OrderProvider>(context, listen: false)
          .getOrderDetails(orderID: widget.orderCode);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  List<LatLng> polyLineCoordinate = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyDXGVyh9MTUKU38syRDuzyWD0SBmUFkp2M",
        PointLatLng(widget.sourceLat, widget.sourceLong),
        PointLatLng(widget.destinationLat, widget.destinationLong));
    if (result.points.isNotEmpty) {
      print("not not not");
      for (var points in result.points) {
        polyLineCoordinate.add(LatLng(points.latitude, points.longitude));
      }
    } else {
      print(result.points);
    }
    setState(() {});
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
                // LatLng sourceLocation = LatLng(
                //     value.detailsData[0].location.coordinates[1],
                //     value.detailsData[0].location.coordinates[0]);
                // LatLng destinationLocation = LatLng(
                //     value.detailsData[0].location.coordinates[0],
                //     value.detailsData[0].location.coordinates[1]);

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
                                    "Name: ${value.detailsData[0].data.user.firstName}"),
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
                    value.detailsData[0].data.status == "ONGOING"
                        ? _isLoading
                            ? Center(
                                child: CircularProgressIndicator.adaptive())
                            : GestureDetector(
                                onTap: () {
                                  try {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    value
                                        .markAsDeliveredOrder(
                                            orderID: widget.orderCode,
                                            userID: Provider.of<AuthProvider>(
                                                    context,
                                                    listen: false)
                                                .userID!)
                                        .then((_) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.of(context).pop();
                                      showSuccessMessage(250, context,
                                          "Product Delivered Success");
                                    });
                                  } catch (_) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 42,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10.0)),
                                        child: Text("Mark as delivered"),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        : value.detailsData[0].data.status == "PENDING"
                            ? _isLoading
                                ? Center(
                                    child: CircularProgressIndicator.adaptive())
                                : GestureDetector(
                                    onTap: () {
                                      try {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        value
                                            .acceptOrder(
                                                orderID: widget.orderCode,
                                                userID:
                                                    Provider.of<AuthProvider>(
                                                            context,
                                                            listen: false)
                                                        .userID!)
                                            .then((_) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          Navigator.of(context).pop();
                                          showSuccessMessage(250, context,
                                              "Product Accepted Success");
                                        });
                                      } catch (_) {
                                        _isLoading = false;
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 42,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Text("Accept Order"),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              try {
                                                setState(() {
                                                  _isLoading = true;
                                                });
                                                value
                                                    .cancelOrder(
                                                        orderID:
                                                            widget.orderCode,
                                                        userID: Provider.of<
                                                                    AuthProvider>(
                                                                context,
                                                                listen: false)
                                                            .userID!)
                                                    .then((_) {
                                                  setState(() {
                                                    _isLoading = false;
                                                  });
                                                  Navigator.of(context).pop();
                                                  showSuccessMessage(
                                                      250,
                                                      context,
                                                      "Product Cancled Success");
                                                });
                                              } catch (_) {
                                                _isLoading = false;
                                              }
                                            },
                                            child: Container(
                                              height: 42,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0)),
                                              child: Text("Cancel Order"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                            : Container(),
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        height: 170,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: GoogleMap(
                            // mapType: MapType.satellite,
                            myLocationButtonEnabled: true,
                            indoorViewEnabled: true,
                            // trafficEnabled: true,
                            // liteModeEnabled: true,
                            myLocationEnabled: true,
                            initialCameraPosition: CameraPosition(
                                target:
                                    LatLng(widget.sourceLat, widget.sourceLong),
                                zoom: 10),
                            markers: {
                              Marker(
                                  markerId: MarkerId("source"),
                                  position: LatLng(
                                      widget.sourceLat, widget.sourceLong)),
                              Marker(
                                  markerId: MarkerId("destination"),
                                  position: LatLng(widget.destinationLat,
                                      widget.destinationLong)),
                            },
                            polylines: {
                              Polyline(
                                  polylineId: const PolylineId("Route"),
                                  points: polyLineCoordinate,
                                  color: Colors.red.shade300,
                                  width: 5)
                            },
                          ),
                        ),
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
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          itemCount: value.detailsData[0].data.products.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text(value.detailsData[0].data.products[index]
                                    .product.name),
                                SizedBox(height: 3),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Quntity"),
                                        Text(
                                            "x${value.detailsData[0].data.products[index].quantity.toString()}")
                                      ],
                                    ),
                                    Text(
                                        "Br ${(value.detailsData[0].data.products[index].quantity * value.detailsData[0].data.products[index].product.price)}"
                                            .toString())
                                  ],
                                ),
                                SizedBox(height: 5)
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Sub Total"),
                              Text(
                                  "Br ${value.detailsData[0].data.totalPrice.toString()}"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tax"),
                              Text(
                                  ("Br ${value.detailsData[0].data.totalPrice * 0.15}")
                                      .toString()),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Service charge"),
                              Text(
                                  ("Br ${value.detailsData[0].data.totalPrice * 0.1}")
                                      .toString()),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Grand Total"),
                                Text(
                                  "Br ${((value.detailsData[0].data.totalPrice * 0.25) + value.detailsData[0].data.totalPrice).toString()}",
                                )
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 40),
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
