import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../controller/auth.dart';
import '../controller/dashboard.dart';
import '../controller/notification.dart';
import '../controller/order.dart';
import '../controller/profile.dart';
import 'login.dart';
import 'notification.dart';
import 'update_password.dart';
import 'package:provider/provider.dart';
import 'package:basic_utils/basic_utils.dart' as st;

import '../util/bottom_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future _userData;
  @override
  void didChangeDependencies() {
    _userData = Provider.of<ProfileProvider>(context, listen: false).getProfile(
        userID: Provider.of<AuthProvider>(context, listen: false).userID!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Provider.of<ProfileProvider>(context).userData.isNotEmpty
          ? ProfileWidget()
          : FutureBuilder(
              future: _userData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text("Unknown error"));
                  } else {
                    return ProfileWidget();
                  }
                }
              },
            ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Consumer<ProfileProvider>(
      builder: (context, value, _) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                //
                //User Image
                //
                Center(
                  child: Container(
                    height: screenSize.width * 0.25,
                    width: screenSize.width * 0.25,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red.withOpacity(0.1),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(
                                value.userData[0].profile.profile),
                            fit: BoxFit.cover)),
                  ),
                ),

                const SizedBox(height: 10),
                //
                //User Name
                //
                Center(
                    child: Text(
                  st.StringUtils.capitalize(
                      "${value.userData[0].profile.firstName} "
                      "${value.userData[0].profile.lastName}",
                      allWords: true),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                )),
                const SizedBox(height: 8),
                //
                //User Phone
                //
                Center(
                    child: Text(
                  value.userData[0].profile.phone
                      .toString()
                      .replaceAll("251", "+251 "),
                  style: const TextStyle(fontSize: 15),
                )),

                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.3),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.notification_important_outlined,
                            size: 22),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Notification",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdatePassword(),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.3),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.system_update, size: 22),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Update Password",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).signOut();
                    Provider.of<OrderProvider>(context, listen: false)
                        .clearOrders();
                    Provider.of<NotificationProvider>(context, listen: false)
                        .cleanNotofication();
                    Provider.of<DashboardProvider>(context, listen: false)
                        .clearDashboard();
                    Provider.of<ProfileProvider>(context, listen: false)
                        .clearProfile();
                    Provider.of<BottomBarProvider>(context, listen: false)
                        .resetIndex();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.3),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.logout, size: 22),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "Log Out",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        );
      },
    );
  }
}
