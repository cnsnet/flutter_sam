import 'package:flutter/material.dart';
//import './Quake/Quake.dart';
//import './Weather/Weather.dart';
//import './ui/Login.dart';
//import './Database/FileDemo.dart';
//import './Database/DatabaseDemo.dart';
import './Firebase/FirebaseDemo.dart';
//import './Animation/AnimationDemo.dart';

void main() async {
  var title = "Animation Demo";

  runApp(new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      home: new FirebaseDemo(
        title: title,
      )));
}
