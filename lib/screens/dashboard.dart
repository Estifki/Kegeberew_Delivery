import 'package:flutter/material.dart';
import 'package:kegeberew_delivery/controller/auth.dart';
import 'package:kegeberew_delivery/controller/dashboard.dart';
import 'package:kegeberew_delivery/controller/notification.dart';
import 'package:kegeberew_delivery/util/app_bar.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  late Future _dashBoardData;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _dashBoardData = Provider.of<DashboardProvider>(context, listen: false)
          .getDashbord(
              userID:
                  Provider.of<AuthProvider>(context, listen: false).userID!);
      Provider.of<NotificationProvider>(context, listen: false).getNotification(
          context, Provider.of<AuthProvider>(context, listen: false).userID!);
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 56),
          child: CustomAppBar(title: "Dashboard")),
      body: Provider.of<DashboardProvider>(context).dashboardData.isNotEmpty
          ? DashboardWidget()
          : FutureBuilder(
              future: _dashBoardData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text("Unknown error"));
                  } else {
                    return DashboardWidget();
                  }
                }
              },
            ),
    );
  }
}

class DashboardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<DashboardProvider>(
      builder: (context, value, _) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomePageCounterWidget(
                      title: "Completed Delivery",
                      count: value.dashboardData[0].completedOrders.toString(),
                      icon: Icons.car_rental_rounded,
                      color: Colors.green),
                  const SizedBox(width: 30),
                  HomePageCounterWidget(
                      title: "Pending Delivery",
                      count: value.dashboardData[0].pendingOrders.toString(),
                      icon: Icons.timer_3_select_sharp,
                      color: Colors.orange)
                ],
              ),
              const SizedBox(height: 30),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                HomePageCounterWidget(
                    title: "Canceled Delivery",
                    count: value.dashboardData[0].canceledOrders.toString(),
                    icon: Icons.card_travel_outlined,
                    color: Colors.red),
                const SizedBox(width: 30),
                Container(
                    height: 120, width: MediaQuery.of(context).size.width * 0.4)
              ]),
              //
              //Ont the way
              //
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(top: 30),
                color: Colors.grey.shade50,
                child: Column(children: [
                  Container(
                    height: 70,
                    width: screenSize.width,
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 30),
                        Icon(Icons.card_travel_outlined),
                        SizedBox(width: 20),
                        Text("On The Way"),
                        Spacer(),
                        Text(value.dashboardData[0].ongoingOrders.toString()),
                        SizedBox(width: 30)
                      ],
                    ),
                  )
                ]),
              ))
            ]);
      },
    );
  }
}

class HomePageCounterWidget extends StatelessWidget {
  final String title;
  final String count;
  final Color color;

  final IconData icon;
  const HomePageCounterWidget(
      {super.key,
      required this.title,
      required this.count,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width * 0.4,
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(height: 10),
          Text(title),
          SizedBox(height: 10),
          Text(count),
        ],
      ),
    );
  }
}
