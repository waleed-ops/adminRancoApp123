import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../main.dart';

Future <void> scheduleAlarm() async{

  // displayDialog("Guest was added, Please Wait for Admin Confirmation!");
  // await Firebase.initializeApp();
  // DocumentReference docRef = await FirebaseFirestore.instance
  //     .collection("guests")
  //     .doc(userid)
  //     .collection("guests")
  //     .add({
  //   "guestNationality": _nationalityTextEditingController.text.trim(),
  //   "guestName": _nameTextEditingController.text.trim(),
  //   "guestId": _idTextEditingController.text.trim(),
  //   "guestUnitNum": _unitNumberTextEditingController.text.trim(),
  //   "guestStatus": _guestStatus.trim(),
  //   "guestUiddsf": guestID.toString(),
  //   // "FFFFFFFF": docRef.documentID,
  //   "guestUid": userid,
  //   // "guestUid": guestUid,
  //   "VisitDate": _date.toString(),
  // });

  FirebaseAuth.instance
      .userChanges()
      .listen((User user) async {

    DocumentReference docRef = (FirebaseFirestore.instance
        .collection("guests")
        .doc(user.uid)
        .collection("guests")) as DocumentReference<Object>;
    if (user == null) {
    } else {
      print("It looks like it worked " + docRef.toString());
      print("Something is wrong");
      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'your channel id', 'your channel name', 'your channel description',
          icon: 'person',
          largeIcon: DrawableResourceAndroidBitmap('person'),
          styleInformation: DefaultStyleInformation(true, true),
          importance: Importance.max, priority: Priority.high, ticker: 'ticker');
      var iOSPlatformChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
      // await flutterLocalNotificationsPlugin.show(
      //     1," _guestStatus", "ffdf", platformChannelSpecifics,
      //     payload: 'item x');
    }
  });


  // var scheduledNotificationDateTime = DateTime.now().add(Duration(seconds: 2));
  //
  // var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //   // 'alarm_notif',
  //   // 'alarm_notif',
  //   // 'Channel for Alarm notification',
  //   'silent channel id',
  //   'silent channel name',
  //   'silent channel description',
  //   playSound: false,
  //   icon: 'person',
  //   // RawResourceAndroidNotificationSound('slow_spring_board'),
  //   // sound: RawResourceAndroidNotificationSound('slow_spring_board'),
  //   // largeIcon: DrawableResourceAndroidBitmap('person'),
  //     styleInformation: DefaultStyleInformation(true, true)
  // );
  // var iOSPlatformChannelSpecifics = IOSNotificationDetails(
  //     // sound: 'slow_spring_board.aiff',
  //     presentAlert: false,
  //     presentBadge: false,
  //     presentSound: false);
  // var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  // await flutterLocalNotificationsPlugin.schedule(
  //     0,
  //     'Office',
  //     "good Morning",
  //     scheduledNotificationDateTime, platformChannelSpecifics);
}