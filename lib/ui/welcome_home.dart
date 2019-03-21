import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.blue,
      child: new Center(
          child: new Text("Hello welcome!",
              textDirection: TextDirection.ltr,
              style: new TextStyle(
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
                fontSize: 34.5,
              ))),
    );
  }
}
