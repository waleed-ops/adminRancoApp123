import 'package:admin_ranco_app/Admin/securityChatPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'about.dart';
import 'adminDrawer.dart';
import 'adminMaintenancePage.dart';
import 'allUsers.dart';
import 'guestsRequested.dart';
import 'login.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
//   print(message.data);
//   flutterLocalNotificationsPlugin.show(
//       message.data.hashCode,
//       message.data['title'],
//       message.data['body'],
//       NotificationDetails(
//         android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channel.description,
//         ),
//       ));
// }
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: securityPage());
  }
}

class securityPage extends StatefulWidget {
  // static const kAppId = "fc152ab9-dd5f-49ff-8d80-bfede75a95e9";
  @override
  _securityPage createState() => _securityPage();
}

class _securityPage extends State<securityPage> {
  FirebaseMessaging _fcm;
  String message;
  String token;

  // int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    // var initialzationSettingsAndroid =
    //     AndroidInitializationSettings('@drawable/person');
    // var initializationSettings =
    //     InitializationSettings(android: initialzationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             icon: android?.smallIcon,
    //           ),
    //         ));
    //   }
    // });
    // getToken();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cardTextStyle = TextStyle(fontSize: 13.0, color: Colors.blue[800]);
    var cardTextStyleSmall =
        TextStyle(fontSize: 10.0, color: Colors.deepPurpleAccent);
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: new BoxDecoration(
              gradient: new LinearGradient(
                colors: [Colors.blue, Colors.deepPurpleAccent],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          title: Text(
            "Ranco App",
            style: TextStyle(
                fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
          ),
          centerTitle: true,
        ),
        drawer: AdminDrawer(),
        body: Column(
          // mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              height: _screenWidth * 1.1,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.topCenter,
                  image: AssetImage("images/bk.png"),
                ),
              ),
              padding: EdgeInsets.only(top: 25),
              child: GridView.count(
                  padding: EdgeInsets.all(3),
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 10,
                  primary: false,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: GestureDetector(
                        onTap: () => {guestsRequestedFunction()},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                "images/icons/adduser.png",
                              ),
                            ),
                            Text(
                              "Guests Requested",
                              style: cardTextStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Confirm Guests Request",
                              style: cardTextStyleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: GestureDetector(
                        onTap: () => {usersList()},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("images/icons/person.png"),
                            ),
                            Text(
                              "All Users",
                              style: cardTextStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "You can See all Users here",
                              style: cardTextStyleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: GestureDetector(
                        onTap: () => {contactSecuirty()},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("images/icons/security.png"),
                            ),
                            Text(
                              "Security Chat",
                              style: cardTextStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Contact users here",
                              style: cardTextStyleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: GestureDetector(
                        onTap: () => {maintenance()},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage("images/icons/maintenance.png"),
                            ),
                            Text(
                              "Maintenance Requested",
                              style: cardTextStyle,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Maintenance Status",
                              style: cardTextStyleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Card(
                    //   shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8)),
                    //   elevation: 4,
                    //   child: GestureDetector(
                    //     // onTap: () => {guestsRequestedFunction()},
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Image(
                    //           image: AssetImage(
                    //             "images/icons/adduser.png",
                    //           ),
                    //         ),
                    //         Text(
                    //           "Guests Archive",
                    //           style: cardTextStyle,
                    //         ),
                    //         SizedBox(
                    //           height: 8,
                    //         ),
                    //         Text(
                    //           " Guests Request Archive",
                    //           style: cardTextStyleSmall,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                  crossAxisCount: 2),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            // currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.deepPurple,
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'MyGuest',
                  backgroundColor: Colors.deepPurple),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'info',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.logout),
                label: 'logout',
              ),
            ],
            onTap: (index) async {
              switch (index) {
                case 0:
                  Route route =
                      MaterialPageRoute(builder: (c) => securityPage());
                  Navigator.pushReplacement(context, route);
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => allUsers()),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                  break;
                case 3:
                  // await FirebaseAuth.instance.signOut();
                  await FirebaseAuth.instance.signOut().then((c) {
                    Route route =
                        MaterialPageRoute(builder: (c) => Login());
                    Navigator.pushReplacement(context, route);
                  });
                  break;
              }
            }),
      ),
    );
  }

  Future guestsRequestedFunction() {
    Navigator.of(context);
    Route route = MaterialPageRoute(builder: (c) => guestsRequested());
    Navigator.push(context, route);
  }

  Future usersList() {
    Navigator.of(context);
    Route route = MaterialPageRoute(builder: (c) => allUsers());
    Navigator.push(context, route);
  }

  Future contactSecuirty() {
    Navigator.of(context);
    Route route = MaterialPageRoute(builder: (c) => securityChatPage());
    Navigator.push(context, route);
  }

  Future maintenance() {
    Navigator.of(context);
    Route route = MaterialPageRoute(builder: (c) => AdminMaintenancePage());
    Navigator.push(context, route);
  }

  //For Notifications
  // Future whaterver() {
  //   FirebaseAuth _auth = FirebaseAuth.instance;
  //   FirebaseFirestore firebaseFirestore =
  //   FirebaseAuth.instance
  //       .userChanges()
  //       .listen((User user) {
  //     if (user == null) {
  //       Route route = MaterialPageRoute(builder: (_) => AuthenticScreen());
  //       Navigator.pushReplacement(context, route);
  //     } else {
  //       Route route = MaterialPageRoute(builder: (_) => HotelHome());
  //       Navigator.pushReplacement(context, route);
  //     }
  //   });
  // }

  // getToken() async {
  //   token = await FirebaseMessaging.instance.getToken();
  //   setState(() {
  //     token = token;
  //   });
  //   // _database.child('fcm-token/${token}').set({"token": token});
  //   print("this is a token number : " + token);
  // }

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Are You Sure ?'),
              content: Text('do you want to exit the App'),
              actions: <Widget>[
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('NO')),
                // ignore: deprecated_member_use
                FlatButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text('YES'))
              ],
            ));
    return shouldPop ?? false;
  }
}
