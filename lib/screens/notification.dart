import 'package:basic_utils/basic_utils.dart' as st;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kegeberew_delivery/util/custom_exception.dart';
import 'package:kegeberew_delivery/util/toast.dart';
import 'package:provider/provider.dart';
import 'package:jiffy/jiffy.dart';
import '../controller/auth.dart';
import '../controller/notification.dart';
import '../util/app_bar.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: CustomAppBarPop(title: "Notification")),
      body: Consumer<NotificationProvider>(builder: (context, value, child) {
        return value.notificationData.isEmpty
            ? const Center(child: Text("No New Notification"))
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        try {
                          await Provider.of<NotificationProvider>(context,
                                  listen: false)
                              .markAllAsRead(
                                  context,
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .userID!);
                        } on CustomException catch (e) {
                          showErrorMessage(
                              width: 250,
                              context: context,
                              errorMessage: e.toString());
                        } catch (e) {
                          showErrorMessage(
                              width: 250,
                              context: context,
                              errorMessage: "Please Try Again Alter");
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10.0, top: 10, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                "Mark all as read",
                                style: TextStyle(fontSize: 14),
                              )),
                        ),
                      ),
                    ),
                    ListView.builder(
                        itemCount: value.notificationData.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 6.0,
                                      left: screenSize.width * 0.03,
                                      right: 10,
                                      bottom: 6.0),
                                  child: Stack(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        value.notificationData[index].readAt ==
                                                null
                                            ? Container(
                                                width: 6,
                                                height: 6,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                margin: const EdgeInsets.only(
                                                    right: 7),
                                                decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                ),
                                              )
                                            : Container(),
                                        // ClipRRect(
                                        //   borderRadius:
                                        //       BorderRadius.circular(50.0),
                                        //   child: CachedNetworkImage(
                                        //     height: 58,
                                        //     width: 58,
                                        //     imageUrl:
                                        //         "${AppConst.picUrl}${value.notificationData[index].profile}",
                                        //     fit: BoxFit.cover,
                                        //   ),
                                        // ),
                                        const SizedBox(width: 15),
                                        Expanded(
                                            child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 16.0),
                                          child: Text(
                                            st.StringUtils.capitalize(value
                                                .notificationData[index]
                                                .message),
                                            style: TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0.0,
                                        child: Text(
                                          Jiffy(value.notificationData[index]
                                                  .createdAt)
                                              .fromNow(),
                                          style: TextStyle(
                                              fontSize: 11.7,
                                              color: Colors.grey.shade100),
                                        ))
                                  ]),
                                ),
                                index == value.notificationData.length - 1
                                    ? Container()
                                    : Container(
                                        margin: const EdgeInsets.only(
                                            top: 3, bottom: 0.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: Colors.black87,
                                        height: 0.075),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              );
      }),
    );
  }
}
