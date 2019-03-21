import 'package:flutter/material.dart';

class MakeItRain extends StatefulWidget {
  final String title;
  MakeItRain({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new MakeItRainState();
  }
}

class MakeItRainState extends State<MakeItRain> {
  int _moneyCounter = 0;
  Color _color = Colors.grey;
  void _rainmoney() {
    setState(() {
      // do {
      //   _moneyCounter = _moneyCounter + 100;

      // } while (_moneyCounter < 10000);
      _moneyCounter = _moneyCounter + 100;

      if (_moneyCounter > 1000) {
        _color = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text(widget.title),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Center(
                child: new Text("Get Rich",
                    style: new TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                    ))),
            new Expanded(
                child: new Center(
              child: new Text(
                "\$$_moneyCounter",
                style: new TextStyle(
                  color: _color,
                  fontSize: 50.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            )),
            new Expanded(
                child: new Center(
                    child: new FlatButton(
              color: Colors.green,
              textColor: Colors.white,
              child: new Text("Let it Rain!",
                  style: new TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                  )),
              onPressed: _rainmoney,
            )))
          ],
        ),
      ),
    );
  }
}
