import 'package:admin_ranco_app/Admin/securityPage.dart';
import 'package:admin_ranco_app/DialogBox/errorDialog.dart';
import 'package:admin_ranco_app/DialogBox/loadingDialog.dart';
import 'package:admin_ranco_app/Widgets/customTextField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

List<Color> _colors = [Colors.blue.shade300, Colors.deepPurpleAccent.shade100];

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: _colors,
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
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
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
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              child: Image.asset(
                "images/admin.png",
                height: 250.0,
                width: 250.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Admin",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: (_emailTextEditingController),
                    data: Icons.person,
                    hintText: "Email",
                    isObsecure: false,
                  ),
                  CustomTextField(
                    controller: _passwordTextEditingController,
                    data: Icons.lock,
                    hintText: "Password",
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              onPressed: () {
                _emailTextEditingController.text.isNotEmpty &&
                        _passwordTextEditingController.text.isNotEmpty
                    ? loginUser()
                    : showDialog(
                        context: context,
                        builder: (c) {
                          return ErrorAlertDialog(
                            message: "Please Fill up the Email & Password",
                          );
                        });
              },
              child: Text(
                "LOGIN",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurpleAccent,
                padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              height: 4.0,
              width: _screenWidth * 0.8,
              color: Colors.blue.shade50,
            ),
            SizedBox(
              height: 15.0,
            ),
            // TextButton.icon(
            //   onPressed: () => Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => AuthenticScreen())),
            //   icon: (Icon(
            //     Icons.nature_people,
            //     color: Colors.deepPurpleAccent,
            //   )),
            //   label: Text(
            //     "I'm Not Secutity",
            //     style:
            //     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            //   ),
            // ),
            SizedBox(
              height: 200.0,
            )
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser() async {
    showDialog(
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Authenticating, Please wait...",
          );
        });
    User firebaseUser;
    await _auth
        .signInWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((authUser) {
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });

    // get the data of this user
    if (firebaseUser != null) {
      readData(firebaseUser).then((s) {
        Navigator.pop(context);
        Route route = MaterialPageRoute(builder: (c) => securityPage());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  Future readData(User fUser) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(fUser.uid)
        .get()
        .then((dataSnapshot) async {
      // await RancoApp.sharedPreferences.setString("uid", dataSnapshot.data()[RancoApp.userUID]);
      // await RancoApp.sharedPreferences.setString(RancoApp.userEmail, dataSnapshot.data()[RancoApp.userEmail]);
      // await RancoApp.sharedPreferences.setString(RancoApp.userName, dataSnapshot.data()[RancoApp.userName]);
      // List<String> cartList = dataSnapshot.data()[RancoApp.userCartList].cast<String>();
      // await RancoApp.sharedPreferences.setStringList(RancoApp.userCartList, cartList);
      // setState(()  {
      //    RancoApp.sharedPreferences?.setString("uid", dataSnapshot.data()[RancoApp.userUID]);
      //    RancoApp.sharedPreferences?.setString(RancoApp.userUID, fUser.uid);
      //    RancoApp.sharedPreferences?.setString(RancoApp.userEmail, dataSnapshot.data()[RancoApp.userEmail]);
      //    RancoApp.sharedPreferences?.setString(RancoApp.userName, dataSnapshot.data()[RancoApp.userName]);
      // });
      // RancoApp.sharedPreferences = await SharedPreferences.getInstance();
      // await RancoApp.sharedPreferences?.setString("uid", dataSnapshot.data()[RancoApp.userUID]);
      // await RancoApp.sharedPreferences?.setString(RancoApp.userUID, fUser.uid);
      // await RancoApp.sharedPreferences?.setString(RancoApp.userEmail, dataSnapshot.data()[RancoApp.userEmail]);
      // await RancoApp.sharedPreferences?.setString(RancoApp.userName, dataSnapshot.data()[RancoApp.userName]);
    });
    // print(" LOLLLL This is mokca " + RancoApp.sharedPreferences.getString(RancoApp.adminName));
  }
}
