import 'package:admin_ranco_app/Admin/adminDrawer.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              colors: [Colors.blue[300], Colors.deepPurpleAccent[100]],
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
      body: Container(
        height: _screenWidth * 2,
        width: _screenWidth * 2,
        decoration: BoxDecoration(
          gradient: new LinearGradient(
            colors: [Colors.blue[300], Colors.deepPurpleAccent[100]],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "About :",
                style: TextStyle(fontSize: 28, color: Colors.white,fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text("RancoApp is an application where you can request guest, mintance, talke to security"
                    "for some purpose, and more.",
                style: TextStyle(fontSize: 21, color: Colors.white70,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
