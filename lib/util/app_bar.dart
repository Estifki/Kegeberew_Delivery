import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
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
        ));
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
          color: Colors.black,
          fontSize: 18,
          // fontFamily: AppFonts.poppinsSemiBold,
        ),
      ),
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          popIcon,
          size: 22,
          color: Colors.black,
        ),
      ),
    );
  }
}
