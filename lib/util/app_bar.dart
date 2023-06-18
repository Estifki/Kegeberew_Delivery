import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constant/const.dart';
import 'package:provider/provider.dart';

import '../controller/notification.dart';
import '../screens/notification.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          // fontFamily: AppFonts.poppinsSemiBold,
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => const NotificationScreen())),
          child: Consumer<NotificationProvider>(builder: (context, value, _) {
            return Stack(children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(right: screenSize.width * 0.025),
                  child: Icon(Icons.notifications_none_outlined,
                      size: screenSize.width * 0.06, color: Colors.white),
                ),
              ),
              value.newNotification != 0
                  ? Positioned(
                      top: 12,
                      right: screenSize.width * 0.015,
                      child: Container(
                        alignment: Alignment.center,
                        height: 17,
                        width: 17,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          value.newNotification.toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ))
                  : Container(),
            ]);
          }),
        )
      ],
    );
  }
}

class CustomAppBarPop extends StatelessWidget {
  final String title;
  final IconData popIcon;

  const CustomAppBarPop({
    super.key,
    required this.title,
    this.popIcon = Icons.arrow_back_ios,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          // fontFamily: AppFonts.poppinsSemiBold,
        ),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          popIcon,
          size: 22,
          color: Colors.white,
        ),
      ),
    );
  }
}
