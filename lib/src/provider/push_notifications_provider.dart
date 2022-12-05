import 'dart:async';
import 'dart:convert';

import 'package:comedor_utt/src/provider/users_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;


class PushNotificationsProvider {

  AndroidNotificationChannel channel;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  bool isFlutterLocalNotificationsInitialized = false;

  Future<void> initPushNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  // void showFlutterNotification(RemoteMessage message) {
  //   RemoteNotification notification = message.notification;
  //   AndroidNotification android = message.notification?.android;
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //           channelDescription: channel.description,
  //           icon: 'local_restaurant',
  //         ),
  //       ),
  //     );
  //     print('showFlutterNotification: A new onMessageOpenedApp event was published!');
  //   }
  // }

  void onMessageListener() async {

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'local_restaurant',
            ),
          )
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageListener: A new onMessageOpenedApp event was published!');
    });
  }

  

  void saveToken(String idUser) async {
    String token = await FirebaseMessaging.instance.getToken();
    UsersProvider usersProvider = UsersProvider();
    await usersProvider.updateNotificationToken(idUser, token);
  }

  Future<void> sendMessage(String to, Map<String, dynamic> data, String title, String body) async {

    Uri url = Uri.https('fcm.googleapis.com', '/fcm/send');

    await http.post(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json',
          'Authorization': 'key=BBy3wOSxxl7Igvi2HxeeWd0VydXiKeMaNxpDdV9kd24tnzmn_isfwnidIynoEdcS2fz2BjNDi1pN6FACRnruNgg'
        },
        body: jsonEncode(
            <String, dynamic> {
              'notification': <String, dynamic> {
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'ttl': '4500s',
              'data': data,
              'to': to
            }
        )
    );
  }

  Future<void> sendMessageMultiple(List<String> toList, Map<String, dynamic> data, String title, String body) async {

    Uri url = Uri.https('fcm.googleapis.com', '/fcm/send');

    await http.post(
        url,
        headers: <String, String> {
          'Content-Type': 'application/json',
          'Authorization': 'key=BBy3wOSxxl7Igvi2HxeeWd0VydXiKeMaNxpDdV9kd24tnzmn_isfwnidIynoEdcS2fz2BjNDi1pN6FACRnruNgg'
        },
        body: jsonEncode(
            <String, dynamic> {
              'notification': <String, dynamic> {
                'body': body,
                'title': title,
              },
              'priority': 'high',
              'ttl': '4500s',
              'data': data,
              'registration_ids': toList
            }
        )
    );
  }
}