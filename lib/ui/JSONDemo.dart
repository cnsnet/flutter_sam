import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

class JSONDemo extends StatefulWidget {
  final String title;
  JSONDemo({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new JSONDemoState();
  }
}

class JSONDemoState extends State<JSONDemo> {
  List _data = new List();
  void getData() async {
    _data = await getJson();

    // for (int i = 0; i < _data.length; i++) {
    //   print(_data[i]["title"]);
    // }

    setState(() {});
  }

  void postData() async {
    var _postData = await postJson();
    print(_postData["result"]);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.get_app),
            onPressed: postData,
          )
        ],
      ),
      body: new Container(
          alignment: Alignment.topCenter,
          child: new ListView.builder(
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int position) {
                return new Column(
                  children: <Widget>[
                    new Divider(
                      height: 5.5,
                    ),
                    new ListTile(
                        title: new Text('${_data[position]["title"]}',
                            style: new TextStyle(fontSize: 18.0)),
                        subtitle: new Text(
                          '${_data[position]["body"]}',
                          style: new TextStyle(
                              fontSize: 13.9,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic),
                        ),
                        leading: new CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          child: new Text(
                            '${_data[position]["body"][0]}',
                            style: new TextStyle(
                                fontSize: 13.4, color: Colors.orangeAccent),
                          ),
                        ),
                        onTap: () => _showOnTapMessages(
                            context, '${_data[position]["body"]}'))
                  ],
                );
              })),
    );
  }
}

void _showOnTapMessages(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text("JSON Parser"),
    content: new Text(message),
    actions: <Widget>[
      new FlatButton(
        child: new Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  //showDialog(context: context,child: alert);
  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJson() async {
  String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  try {
    Response response = await Dio().get(apiUrl);

    return response.data;
  } catch (e) {
    debugPrint(e);
  }

  return null;
}

Future<Map> postJson() async {
  String apiUrl = "https://sdk.costruct.app/CheckEmail.json";

  try {
    FormData formData =
        new FormData.from({"email": "johnzhang@buildersaccess.com"});
    Response response = await Dio().post(apiUrl, data: formData);

    return response.data;
  } catch (e) {
    debugPrint(e);
  }

  return null;
}
