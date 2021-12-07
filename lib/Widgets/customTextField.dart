import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  IconData data;
  String hintText;
  bool isObsecure = true;

  CustomTextField(
      {Key key, this.controller, this.data, this.hintText, this.isObsecure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.all(6.0),
      child: TextFormField(
        style: TextStyle(color: Colors.deepPurpleAccent),
        controller: controller,
        obscureText: isObsecure,
        cursorColor: Colors.deepPurpleAccent,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.deepPurpleAccent,
          ),
          focusColor: Colors.deepPurpleAccent,
          hintText: hintText,
        ),
      ),
    );
  }
}
