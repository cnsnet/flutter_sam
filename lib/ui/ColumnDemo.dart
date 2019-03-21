import 'package:flutter/material.dart';

class ColumnDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new Container(
      color: Colors.greenAccent,
      alignment: Alignment.center,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text("First item",textDirection: TextDirection.ltr,
          style: new TextStyle(color: Colors.white,)),
          new Text("Column2"),
          new Container(color: Colors.deepOrange.shade50,
          alignment: Alignment.bottomLeft,
          child: new Text("Column3"),)
        ],
      ),
    ));
  }
}
