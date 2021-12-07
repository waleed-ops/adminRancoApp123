import 'package:flutter/material.dart';

import 'adminDrawer.dart';

class securityChatPage extends StatelessWidget {
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
                "Contact Security is not yet implemented, sorry for the inconvenience.",
                style: TextStyle(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text("Coming Soon, Stay Tuned",
                  style: TextStyle(fontSize: 21, color: Colors.white70,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
