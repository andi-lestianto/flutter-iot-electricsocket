import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smartsocket/app/data/notification_model.dart';

class DBServices {
  saveNotificationData({required NotificationAlarm notificationAlarm}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final currentNotificationData = await getAllNotificationData();
    List<Map<String, dynamic>> newDataNotification = [];
    if (currentNotificationData.isNotEmpty) {
      Map<String, dynamic> addedNotification = notificationAlarm.toJson();
      newDataNotification
          .addAll(currentNotificationData.map((e) => e.toJson()).toList());
      newDataNotification.add(addedNotification);
      print(newDataNotification);
    } else {
      Map<String, dynamic> addedNotification = notificationAlarm.toJson();
      newDataNotification.add(addedNotification);
      print(' null');
    }

    final response =
        await sp.setString('NotificationData', jsonEncode(newDataNotification));

    if (response) {
      print('Notification data saved to local');
    } else {
      print('Failed to save notification data to local');
    }
  }

  Future<List<NotificationAlarm>> getAllNotificationData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<NotificationAlarm> data = [];
    final response = await sp.getString('NotificationData');
    if (response != null) {
      List<dynamic> resData = jsonDecode(response);
      data = resData.map((e) => NotificationAlarm.fromJson(e)).toList();
      return data;
    } else {
      return data;
    }
  }

  updateNotificationData(
      {required List<NotificationAlarm> listNotificationAlarm}) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> newDataNotification =
        listNotificationAlarm.map((e) => e.toJson()).toList();

    final response =
        await sp.setString('NotificationData', jsonEncode(newDataNotification));

    if (response) {
      print('Notification data saved to local');
    } else {
      print('Failed to save notification data to local');
    }
  }
}
