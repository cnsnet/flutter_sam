import 'package:flutter/material.dart';

class ScaffoldDemo extends StatelessWidget {
  final String title;
  ScaffoldDemo({Key key, this.title}) : super(key: key);

  void _onPress() => debugPrint("Search tapped!");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        title: new Text(title),
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: null,
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.send),
            onPressed: () => debugPrint("Icon tapped!"),
          ),
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: _onPress,
          )
        ],
      ),
      backgroundColor: Colors.lightGreen.shade50,
      body: new Container(
        alignment: Alignment.center,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              "data",
              style: new TextStyle(fontSize: 20, color: Colors.black),
            ),
            new InkWell(
              child: new Text("Button!"),
              onTap: () => debugPrint("Button Tapped!"),
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.lightGreen,
        tooltip: "New Project",
        child: new Icon(Icons.add),
        onPressed: () => debugPrint("FloatingActionButton Tapped!"),
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
              icon: new Icon(Icons.home), title: new Text("Home")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.chat), title: new Text("Chat"))
        ],
        onTap: (i) => debugPrint("Tapped index $i"),
      ),
    );
  }
}
