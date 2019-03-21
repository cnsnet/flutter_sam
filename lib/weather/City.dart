import 'package:flutter/material.dart';

class City extends StatefulWidget {
  final Widget child;

  City({Key key, this.child}) : super(key: key);

  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: widget.child,
    );
  }
}