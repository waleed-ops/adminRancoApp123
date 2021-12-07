import 'package:admin_ranco_app/Admin/login.dart';
import 'package:admin_ranco_app/Admin/securityPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'about.dart';
import 'allUsers.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawer createState() => _AdminDrawer();
}

class _AdminDrawer extends State<AdminDrawer> {
  List<Color> _colors = [
    Colors.blue.shade300,
    Colors.deepPurpleAccent.shade100
  ];
  String adminName;
  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    getAdminName(adminName);
  }

  //  loginAdmin(String adminName) {
  //   // This will get all the admins info
  //   FirebaseFirestore .instance
  //       .collection("admins")
  //       .get()
  //       .then((snapshot) async {
  //     // this to seperetate it fomr each other
  //     snapshot.docs.forEach((result) {
  //       if (result.data()["id"]!= null) {
  //         result.data()["name"] = adminName;
  //         setState(() {
  //           adminName = result.data()["name"];
  //         });
  //       } else {
  //         print("Admin has no name");
  //       }
  //     });
  //   });
  // }

  getAdminName(String adminName) {
    // This will get all the admins info
    FirebaseFirestore.instance
        .collection("admins")
        .get()
        .then((snapshot) async {
      // this to seperetate it fomr each other
      snapshot.docs.forEach((result) async {
        if (result.data()["id"] != null) {
          return adminName = result.data()["name"] ?? "nuill";
          print("This is the Name Admin " + result.data()["id"]);
        } else {
          // Scaffold.of(context).showSnackBar(SnackBar(
          //   content: Text("Welcome Dear Admin" + result.data()["name"]),
          // ));
          // // where admin will go after login
          // Route route = MaterialPageRoute(builder: (c) => securityPage());
          // Navigator.pushReplacement(context, route);
          print("There is no data here, Admin is empty");
        }
      });
    });
  }

  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            colors: _colors,
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
          ),
        ),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 25.0, bottom: 15.0),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: _colors,
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                children: [
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 8.0,
                    child: Container(
                      height: 130.0,
                      width: 130.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  // Text(
                  //   RancoApp.sharedPreferences.getString(RancoApp.adminName),
                  //   style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 35.0,
                  //       fontFamily: "Signatra"),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  colors: _colors,
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Column(
                children: [
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => securityPage());
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      "All Users",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Route route =
                          MaterialPageRoute(builder: (c) => allUsers());
                      Navigator.push(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: Text(
                      "About",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) => About());
                      Navigator.push(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((c) {
                        Route route =
                            MaterialPageRoute(builder: (c) => Login());
                        Navigator.pushReplacement(context, route);
                      });
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.white,
                    thickness: 2.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// getAdminName(String adminName) {
//    // This will get all the admins info
//    FirebaseFirestore.instance
//        .collection("admins")
//        .get()
//        .then((snapshot) async {
//      // this to seperetate it fomr each other
//      snapshot.docs.forEach((result) async {
//        if (result.data()["id"] != null) {
//          return adminName = result.data()["name"]??"nuill";
//          print("This is the Name Admin " + result.data()["id"]);
//        } else {
//          // Scaffold.of(context).showSnackBar(SnackBar(
//          //   content: Text("Welcome Dear Admin" + result.data()["name"]),
//          // ));
//          // // where admin will go after login
//          // Route route = MaterialPageRoute(builder: (c) => securityPage());
//          // Navigator.pushReplacement(context, route);
//          print("There is no data here, Admin is empty");
//        }
//      });
//    });
//  }
}
