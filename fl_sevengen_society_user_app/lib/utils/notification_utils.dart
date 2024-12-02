import 'dart:convert';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_sevengen_society_user_app/common/data/model/push_notification_model.dart';
import 'package:fl_sevengen_society_user_app/enums/app_enums.dart';
import 'package:fl_sevengen_society_user_app/utils/app_constants.dart';
import 'package:fl_sevengen_society_user_app/utils/storage_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'log_utils.dart';

class NotificationUtils {
  static final NotificationUtils _notificationUtils = NotificationUtils();

  static NotificationUtils get notificationUtilsInstance => _notificationUtils;

  List<NotificationReceiveListener> listener = [];

  // Create a [AndroidNotificationChannel] for heads up notifications
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.',
    // description
    importance: Importance.high,
  );

  /// Initialize the [FlutterLocalNotificationsPlugin] package.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// Define a top-level named handler which background/terminated messages will
  /// call.
  ///
  /// To verify things are working, check out the native platform logs.
  // Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  //   // If you're going to use other Firebase services in the background, such as Firestore,
  //   // make sure you call `initializeApp` before using other Firebase services.
  //   await Firebase.initializeApp();
  //   LogUtils.printLog(tag: "Handling a background message", message: '${message.messageId}');
  // }

  initFirebase() async {
    // Set the background messaging handler early on, as a named top-level function
    //  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
   await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

    /// Note: permissions aren't requested here just to demonstrate that can be
    /// done later
    final DarwinInitializationSettings initializationSettingsIOS = 
      const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

    final InitializationSettings initializationSettings = InitializationSettings(
    android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
    iOS: initializationSettingsIOS,
  );
    await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      final String? payload = response.payload;
      if (payload != null) {
        PushNotificationModel pushNotificationModel =
            PushNotificationModel.fromJson(json.decode(payload));
        LogUtils.printLog(
            tag: "PushNotification -- onSelectNotification",
            message: "${pushNotificationModel.toJson()}");
      }
    },
  );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    setupListener();
  }

  // for background notifications called form main
  void showBackGroundNotification(RemoteMessage message) {
    LogUtils.printLog(tag: "PushNotification ", message: "${message.data}");

    PushNotificationModel? pushNotificationModel =
        PushNotificationModel.fromJson(message.data);

    // if (pushNotificationModel.status == NotificationStatusEnums.userBlocked.value) {
    //   AppUtils.appUtilsInstance.handleUnauthorizedCase();
    // } else if (pushNotificationModel.status == NotificationStatusEnums.userUnBlocked.value) {
    // } else {
    //   listener.forEach((element) {
    //     element.onNotificationReceive(pushNotificationModel);
    //   });
    // }
    int notificationId = Random().nextInt(1000);
    flutterLocalNotificationsPlugin.show(
        notificationId,
        pushNotificationModel.title ?? appName,
        pushNotificationModel.body ?? message.data["noti_title"] ?? "",
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            // priority: Priority.defaultPriority,
            // importance: Importance.defaultImportance,
            // ongoing: true,
            styleInformation: const BigTextStyleInformation(''),
          ),
        ),
        payload: json.encode(pushNotificationModel.toJson()));
  }

  setupListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // LogUtils.printLog(tag: "PushNotification notification", message: "${message.notification}");
      LogUtils.printLog(tag: "PushNotification ", message: "${message.data}");

      PushNotificationModel? pushNotificationModel =
          PushNotificationModel.fromJson(message.data);
      for (var element in listener) {
        element.onNotificationReceive(pushNotificationModel);
      }

      /*if (pushNotificationModel.status == NotificationStatusEnums.userBlocked.value) {
        AppUtils.appUtilsInstance.handleUnauthorizedCase();
      } else if (pushNotificationModel.status ==
          NotificationStatusEnums.userUnBlocked.value) {
      } else {
        listener.forEach((element) {
          element.onNotificationReceive(pushNotificationModel);
        });
      }*/

      int notificationId = Random().nextInt(1000);
      flutterLocalNotificationsPlugin.show(
          notificationId,
          pushNotificationModel.title ?? appName,
          pushNotificationModel.body ?? message.data["noti_title"] ?? "",
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              priority: Priority.high,
              ongoing: true,
              styleInformation: const BigTextStyleInformation(''),
            ),
          ),
          payload: json.encode(pushNotificationModel.toJson()));
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      LogUtils.printLog(
          tag: "Notification", message: 'A new onMessageOpenedApp event was published!');
    });
    FirebaseMessaging.instance.getToken().then((value) {
      LogUtils.printLog(tag: "Notification Token", message: '$value');
      StorageUtils.storageUtilsInstance
          .saveToPermanentStorage(key: StorageUtilsEnum.fcmToken.value, value: value);
    });
  }
}

class NotificationReceiveListener {
  onNotificationReceive(PushNotificationModel data) {}
}
