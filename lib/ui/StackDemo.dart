import 'package:flutter/material.dart';

class StackDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.greenAccent,
      alignment: Alignment.center,
      child: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          const Text("Hello there"),
          const Text("Hey again!"),
          const Text("1")
        ],
      ),
    );
  }
}
