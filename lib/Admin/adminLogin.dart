// import 'package:admin_ranco_app/Admin/login.dart';
// import 'package:admin_ranco_app/DialogBox/errorDialog.dart';
// import 'package:admin_ranco_app/Widgets/customTextField.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// List<Color> _colors = [Colors.blue.shade300, Colors.deepPurpleAccent.shade100];
//
// class AdminSignInPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: new BoxDecoration(
//             gradient: new LinearGradient(
//               colors: _colors,
//               begin: const FractionalOffset(0.0, 0.0),
//               end: const FractionalOffset(1.0, 0.0),
//               stops: [0.0, 1.0],
//               tileMode: TileMode.clamp,
//             ),
//           ),
//         ),
//         title: Text(
//           "Ranco App",
//           style: TextStyle(
//               fontSize: 55.0, color: Colors.white, fontFamily: "Signatra"),
//         ),
//         centerTitle: true,
//       ),
//       body: AdminSignInScreen(),
//     );
//   }
// }
//
// class AdminSignInScreen extends StatefulWidget {
//   @override
//   _AdminSignInScreenState createState() => _AdminSignInScreenState();
// }
//
// class _AdminSignInScreenState extends State<AdminSignInScreen> {
//   final TextEditingController _adminIDTextEditingController =
//       TextEditingController();
//   final TextEditingController _passwordTextEditingController =
//       TextEditingController();
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     // loginAdmin().whenComplete(() {
//     //   setState(() {});
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double _screenWidth = MediaQuery.of(context).size.width,
//         _screenHeight = MediaQuery.of(context).size.height;
//     return SingleChildScrollView(
//       child: Container(
//         decoration: new BoxDecoration(
//           gradient: new LinearGradient(
//             colors: _colors,
//             begin: const FractionalOffset(0.0, 0.0),
//             end: const FractionalOffset(1.0, 0.0),
//             stops: [0.0, 1.0],
//             tileMode: TileMode.clamp,
//           ),
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Container(
//               child: Image.asset(
//                 "images/admin.png",
//                 height: 250.0,
//                 width: 250.0,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Text(
//                 "Admin",
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28.0,
//                     fontWeight: FontWeight.bold),
//               ),
//             ),
//             Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   CustomTextField(
//                     controller: (_adminIDTextEditingController),
//                     data: Icons.person,
//                     hintText: "ID",
//                     isObsecure: false,
//                   ),
//                   CustomTextField(
//                     controller: _passwordTextEditingController,
//                     data: Icons.lock,
//                     hintText: "Password",
//                     isObsecure: true,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _adminIDTextEditingController.text.isNotEmpty &&
//                         _passwordTextEditingController.text.isNotEmpty
//                     ? loginAdmin()
//                     : showDialog(
//                         context: context,
//                         builder: (c) {
//                           return ErrorAlertDialog(
//                             message: "Please Fill up the Email & Password",
//                           );
//                         });
//               },
//               child: Text(
//                 "LOGIN",
//                 style: TextStyle(color: Colors.white, fontSize: 25.0),
//               ),
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepPurpleAccent,
//                 padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12), // <-- Radius
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             Container(
//               height: 4.0,
//               width: _screenWidth * 0.8,
//               color: Colors.blue.shade50,
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//             TextButton.icon(
//               onPressed: () => Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Login())),
//               icon: (Icon(
//                 Icons.nature_people,
//                 color: Colors.deepPurpleAccent,
//               )),
//               label: Text(
//                 "I'm Not Secutity",
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ),
//             ),
//             SizedBox(
//               height: 200.0,
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> loginAdmin() async {
//     // This will get all the admins info
//     FirebaseFirestore.instance
//         .collection("admins")
//         .get()
//         .then((snapshot) async {
//       // this to seperetate it fomr each other
//       snapshot.docs.forEach((result) async {
//         if (result.data()["id"] != _adminIDTextEditingController.text.trim()) {
//           Scaffold.of(context).showSnackBar(SnackBar(
//             content: Text("your ID is not correct"),
//           ));
//         } else if (result.data()["password"] !=
//             _passwordTextEditingController.text.trim()) {
//           Scaffold.of(context).showSnackBar(SnackBar(
//             content: Text("your Password is not correct"),
//           ));
//         } else {
//           Scaffold.of(context).showSnackBar(SnackBar(
//             content: Text("Welcome Dear Admin" + result.data()["name"]),
//           ));
//
//           // setState((){
//           //   this.preferences.setString(RancoApp.adminName,result.data()["name"]);
//           // });
//           //
//
//           void _incrementCounter() async {
//             setState(() {
//               RancoApp.sharedPreferences
//                   .setString(RancoApp.adminName, result.data()["name"]);
//             });
//           }
//
//           RancoApp.sharedPreferences = await SharedPreferences.getInstance();
//           RancoApp.sharedPreferences
//               ?.setString(RancoApp.adminName, result.data()["name"]);
//           print(RancoApp.sharedPreferences?.getString(RancoApp.adminName));
//
//           // SharedPreferences prefs = await SharedPreferences.getInstance();
//           // // String adminNameVar = result.data()["name"];
//           //  prefs.setString != null? (RancoApp.adminName, adminNameVar);
//           // print("This is my name " + adminNameVar);
//           setState(() {
//             _adminIDTextEditingController.text = "";
//             _passwordTextEditingController.text = "";
//           });
//
//           // where admin will go after login
//           Route route = MaterialPageRoute(builder: (c) => securityPage());
//           Navigator.pushReplacement(context, route);
//         }
//         print("This is the ID " + result.data()["id"]);
//       });
//     });
//   }
// }
