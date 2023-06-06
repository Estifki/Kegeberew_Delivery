import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kegeberew_delivery/screens/order/my_delivery.dart';
import 'package:kegeberew_delivery/screens/profile.dart';
import 'package:provider/provider.dart';

import '../screens/dashboard.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({super.key});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  List<Widget> _screen = [
    HomeScreen(),
    MyDeliveryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _screen.elementAt(
          Provider.of<BottomBarProvider>(context).selectedIndex,
        ),
        bottomNavigationBar: SizedBox(
          height: Platform.isIOS ? null : 56,
          child: BottomNavigationBar(
              // backgroundColor: AppColor.lightBackground,
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              // fixedColor: AppColor.primaryColor,
              // iconSize: 24,
              unselectedLabelStyle: const TextStyle(fontSize: 11.0),
              selectedLabelStyle: const TextStyle(fontSize: 13.0),
              currentIndex:
                  Provider.of<BottomBarProvider>(context).selectedIndex,
              onTap: (index) {
                Provider.of<BottomBarProvider>(context, listen: false)
                    .onIndexChange(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "Dashboard"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "My Delivery"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: "Profile"),
              ]),
        ));
  }
}

class BottomBarProvider with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void onIndexChange(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }

  void resetIndex() {
    _selectedIndex = 0;
  }
}
