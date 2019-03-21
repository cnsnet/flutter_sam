import 'package:flutter/material.dart';

class RowDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            "Row1",
            textDirection: TextDirection.ltr,
          ),
          new Text(
            "Row2",
            textDirection: TextDirection.ltr,
          ),
          new Text(
            "Row3",
            textDirection: TextDirection.ltr,
          ),
          const Expanded(child: const Text("Row4"),)
        ],
      ),
    );
  }
}
