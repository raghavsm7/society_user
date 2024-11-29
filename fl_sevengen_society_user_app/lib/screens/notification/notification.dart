import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';

import '../../theme/theme.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final notificationList = [
    {
      "image": "assets/notification/technician.png",
      "title": "Jesika taylor",
      "detail": "Posted in help desk for plumbing.",
      "time": "2 min"
    },
    {
      "image": "assets/home/bookAmenities.png",
      "title": "Admin",
      "detail": "Approve your amenity booking.",
      "time": "5 min"
    },
    {
      "image": "assets/home/noticeBoard.png",
      "title": "Notice board",
      "detail": "Posted in help desk for plumbing.",
      "time": "10 min"
    },
    {
      "image": "assets/home/payment.png",
      "title": "Maintenance charge",
      "detail": "Not paid of maintenance charges",
      "time": "10 min"
    },
    {
      "image": "assets/notification/technician.png",
      "title": "Jesika taylor",
      "detail": "Posted in help desk for plumbing.",
      "time": "15 min"
    },
    {
      "image": "assets/home/bookAmenities.png",
      "title": "Admin",
      "detail": "Approve your amenity booking.",
      "time": "1 hr"
    },
    {
      "image": "assets/home/noticeBoard.png",
      "title": "Notice board",
      "detail": "Posted in help desk for plumbing.",
      "time": "1 hr"
    },
    {
      "image": "assets/home/payment.png",
      "title": "Maintenance charge",
      "detail": "Not paid of maintenance charges",
      "time": "2 hr"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: black33Color,
          ),
        ),
        title: Text(
          getTranslate(context, 'notification.notification'),
          style: semibold18Black33,
        ),
      ),
      body: notificationList.isEmpty
          ? emptyNotificationListContent()
          : notificationListContent(),
    );
  }

  emptyNotificationListContent() {
    return Center(
      child: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        shrinkWrap: true,
        children: [
          const Iconify(
            Ep.mute_notification,
            color: greyColor,
            size: 48.0,
          ),
          heightSpace,
          Text(
            getTranslate(context, 'notification.no_new_notification'),
            style: semibold16Grey,
            textAlign: TextAlign.center,
          ),
          heightSpace,
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  notificationListContent() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: fixPadding),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              notificationList.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 1500),
                backgroundColor: blackColor,
                behavior: SnackBarBehavior.floating,
                content: Text(
                  getTranslate(
                      context, 'notification.removed_from_notification'),
                  style: semibold15White,
                ),
              ),
            );
          },
          background: Container(
            color: redColor,
            margin: const EdgeInsets.symmetric(vertical: fixPadding),
          ),
          child: Container(
            padding: const EdgeInsets.all(fixPadding),
            margin: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0, vertical: fixPadding),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: shadowColor.withOpacity(0.2),
                  blurRadius: 6.0,
                )
              ],
            ),
            child: Row(
              children: [
                Container(
                  height: 45.0,
                  width: 45.0,
                  padding: const EdgeInsets.all(fixPadding / 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: const Color(0xFFCBDAF0),
                  ),
                  child: Image.asset(
                    notificationList[index]['image'].toString(),
                    fit: BoxFit.cover,
                  ),
                ),
                widthSpace,
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notificationList[index]['title'].toString(),
                              style: semibold16Black33,
                            ),
                            heightBox(3.0),
                            Text(
                              notificationList[index]['detail'].toString(),
                              style: medium14Grey,
                            )
                          ],
                        ),
                      ),
                      Text(
                        notificationList[index]['time'].toString(),
                        style: medium14Grey,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
