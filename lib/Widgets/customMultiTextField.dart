import 'package:flutter/material.dart';

class CustomMultiTextField extends StatelessWidget
{
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final int minLines;
  final int maxLines;





  // Container(
  // decoration: BoxDecoration(
  // color: Colors.white,
  // borderRadius: BorderRadius.all(Radius.circular(10.0)),
  // ),
  // padding: EdgeInsets.all(4.0),
  // margin: EdgeInsets.all(6.0),
  // child: TextFormField(
  // controller: _problemTextEditingController,
  // minLines: 4,
  // maxLines: 7,
  //
  // keyboardType: TextInputType.multiline,
  // style: TextStyle(color: Colors.deepPurpleAccent),
  // cursorColor: Colors.deepPurpleAccent,
  // decoration: InputDecoration(
  // border: InputBorder.none,
  // focusColor: Colors.deepPurpleAccent,
  // ),
  // ),
  // ),
  CustomMultiTextField(
      {Key key, this.controller, this.data, this.hintText,this.maxLines, this.minLines}
      ) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Container
      (
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      padding: EdgeInsets.all(4.0),
      margin: EdgeInsets.all(6.0),
      child: TextFormField(
        style: TextStyle(color: Colors.deepPurpleAccent),
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        maxLines: maxLines,
        minLines: minLines,
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
