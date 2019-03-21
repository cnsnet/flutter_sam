import 'package:flutter/material.dart';
import 'package:flutter_sam/Animation/counter_animation.dart';

class AnimationDemo extends StatefulWidget {
  final String title;

  AnimationDemo({Key key, this.title}) : super(key: key);

  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1800));

    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.easeInCubic)
      ..addListener(() {
        setState(() {
          debugPrint("Running ${animation.value}");
        });
      });

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new ConterAnimator(title: widget.title,);
    // return new Scaffold(
    //   appBar: new AppBar(
    //     title: new Text(widget.title),
    //     centerTitle: true,
    //   ),
    //   body: new Center(
    //     child: new Text(
    //       "Hello world.",
    //       style: new TextStyle(fontSize: 39.0),
    //     ),
    //   ),
    // );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
