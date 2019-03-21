import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class Quake extends StatefulWidget {
  final String title;
  Quake({Key key, this.title}) : super(key: key);

  @override
  _QuakeState createState() => _QuakeState();
}

class _QuakeState extends State<Quake> {
  var _dateFormatString = new DateFormat.yMMMMd("en_US").add_jm();
  Map _data = new Map();
  int _dataLength = 0;

  void _getData() async {
    _data = await getJson();
    _dataLength = _data["features"].length;

    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Quake"),
        backgroundColor: new Color.fromARGB(255, 244, 67, 54),
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.cloud_download),
            onPressed: _getData,
          )
        ],
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView.builder(
          itemCount: _dataLength,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                new Divider(
                  height: 10,
                ),
                new ListTile(
                  title: new Text(
                    '${_dateFormatString.format(new DateTime.fromMillisecondsSinceEpoch(_data["features"][index]["properties"]["time"]))}',
                    style: new TextStyle(
                        color: new Color.fromARGB(255, 255, 145, 0),
                        fontSize: 20.0),
                  ),
                  subtitle: new Text(
                    '${_data["features"][index]["properties"]["place"]}',
                    style: new TextStyle(
                        color: new Color.fromARGB(255, 154, 154, 154),
                        fontStyle: FontStyle.italic),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: new Color.fromARGB(255, 57, 168, 62),
                    child: new Text(
                        '${_data["features"][index]["properties"]["mag"]}'),
                  ),
                  onTap: () => _showOnTapMessages(
                      context,
                      'M ' +
                          '${_data["features"][index]["properties"]["mag"]}' +
                          ' - ' +
                          '${_data["features"][index]["properties"]["place"]}'),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

void _showOnTapMessages(BuildContext context, String message) {
  var alert = new AlertDialog(
    title: new Text("Quakes"),
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

Future<Map> getJson() async {
  String apiUrl =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";

  try {
    Response response = await Dio().get(apiUrl);

    return response.data;
  } catch (e) {
    debugPrint(e);
  }

  return null;
}
