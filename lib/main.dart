import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kegeberew_delivery/controller/dashboard.dart';
import 'package:kegeberew_delivery/controller/notification.dart';
import 'package:kegeberew_delivery/controller/order.dart';
import 'package:kegeberew_delivery/util/bottom_bar.dart';
import 'package:kegeberew_delivery/util/loading.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'controller/auth.dart';
import 'controller/profile.dart';
import 'screens/login.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(ChangeNotifierProvider(
    create: (_) => AuthProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Provider.of<AuthProvider>(context, listen: false).getLoginStatus();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BottomBarProvider()),
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      duration: Duration(milliseconds: 400),
      overlayWidget: Center(child: CustomLoadingWidget()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthProvider>(builder: (context, value, _) {
            if (value.userID == null) {
              return const LoginScreen();
            } else {
              return const CustomBottomBar();
            }
          }),
          theme: ThemeData.dark(),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
