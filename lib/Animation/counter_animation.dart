import 'package:flutter/material.dart';

class ConterAnimator extends StatefulWidget {
  final String title;

  ConterAnimator({Key key, this.title}) : super(key: key);

  @override
  _ConterAnimatorState createState() => _ConterAnimatorState();
}

class _ConterAnimatorState extends State<ConterAnimator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: new Duration(seconds: 3));
    animation = new CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.addListener(() {
      this.setState(() {
        _counter++;

        debugPrint("Counter: $_counter");
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
        child: new GestureDetector(
      child: new Text(
        _controller.isAnimating ? (_counter).toStringAsFixed(2) : "Let's begin",
        style: new TextStyle(fontSize: 24.0 * _controller.value + 16.0),
      ),
      onTap: () {
        _controller.forward(from: 0.0);
      },
    ));
  }
}
