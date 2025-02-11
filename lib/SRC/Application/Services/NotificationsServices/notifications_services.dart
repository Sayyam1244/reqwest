// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reqwest/main.dart';

class NotificationServies {
  static final NotificationServies _notificationServies =
      NotificationServies._internal();
  factory NotificationServies() {
    return _notificationServies;
  }

  NotificationServies._internal();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> permission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'notification_id', // id
    'important_notification', // name
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notificationlow'),
  );

  Future<void> setupFlutterNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    //
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        ontapNotification(
            message: jsonDecode(details.payload!),
            context: navigatorKey.currentContext);
      },
    );
    FirebaseMessaging.onBackgroundMessage(registerBackgroundMessage);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen(
      (event) async {
        // print(event!.toMap().toString());
        showFlutterNotification(event);
      },
    );
  }

  Future<void> showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    AppleNotification? ios = message.notification?.apple;
    if (notification != null && android != null) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            playSound: true,
            message.notification?.android?.channelId ?? '',
            channel.name,
            channelDescription: channel.description,
            sound: RawResourceAndroidNotificationSound(
                message.notification?.android?.sound ?? ''),
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: jsonEncode(message.data),
      );
    }
  }

  static ontapNotification(
      {required Map<String, dynamic> message, BuildContext? context}) {
    log("Payload: $message");
    if (message.isNotEmpty) {
      // switch (message['ACTION']) {
      //   case 'PROFILE':
      //     AppNavigation.to(context!, ProfileScreen());
      //   case 'UPLOAD':
      //     AppNavigation.to(context!, const UploadData());
      //   case 'PRODUCTS':
      //     AppNavigation.to(context!, const ProductsScreen());
      //     break;
      //   default:
      //     AppNavigation.to(context!, const ProductsScreen());
      // }
    }
  }

  ontapNotificationHandlers() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      ontapNotification(
          message: initialMessage.data, context: navigatorKey.currentContext);
    } else {
      print("initialMessage is Empty ${initialMessage?.messageId ?? ''}");
    }
    FirebaseMessaging.onMessageOpenedApp.listen(
      (event) {
        print('bg $event');
        ontapNotification(
            message: event.data, context: navigatorKey.currentContext);
      },
    );
  }
}
