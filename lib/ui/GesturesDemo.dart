import 'package:flutter/material.dart';

class GestureDemo extends StatelessWidget {
  final String title;
  GestureDemo({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text("Gestures"),
      ),
      body: new Center(
        child: new CustomButton(),
        //child: new Scaffold(),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: null,
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        alignment: Alignment.center,
        width: 150,
        height: 60,
        padding: EdgeInsets.all(10.0),
        decoration: new BoxDecoration(
            color: Colors.blue, //Theme.of(context).buttonColor,
            borderRadius: new BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(10.0))),
        child: new Text(
          "Show Snackbar",
          style: new TextStyle(color: Colors.white),
        ),
      ),
      onTap: () {
        final snackBar = new SnackBar(
          content: new Text("I'm snackbar."),
          backgroundColor: Theme.of(context).backgroundColor,
          duration: new Duration(milliseconds: 1000),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
    );
  }
}
