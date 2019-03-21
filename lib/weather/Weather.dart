import 'package:flutter/material.dart';
import '../util/utils.dart' as Util;

class Weather extends StatefulWidget {
  final String title;
  Weather({Key key, this.title}) : super(key: key);

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  String apiUrl =
      "http://api.openweathermap.org/data/2.5/weather?q=${Util.defaultCity}&units=imperial&appid=${Util.apiId}";

  void _getData() async {
    Navigator.pop(context,{"title":"I m back."});
  }

  Widget updateTempWidget(String city) {
    String apiUrl =
        "http://api.openweathermap.org/data/2.5/weather?q=$city&units=imperial&appid=${Util.apiId}";
    return new FutureBuilder(
      future: Util.getData(apiUrl),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.hasData) {
          Map content = snapshot.data;
          return new ListTile(
            title: new Text(
            '${content["main"]["temp"].toString()}℃',
            style: tempStyle(),
          ),
          subtitle: new Text(
            'Humidity:${content["main"]["humidity"].toString()}\n'
            'Min:${content["main"]["temp_min"].toString()}\n'
            'Max:${content["main"]["temp_max"].toString()}\n'
          ),);
        }
        else{
          return new Text("");
        }
      },
    );
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
        title: new Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu),
            onPressed: _getData,
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new Center(
            child: new Image.asset('assets/images/umbrella.png',
                width: 490.0, height: 1200.0, fit: BoxFit.fill),
          ),
          new Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.fromLTRB(0.0, 10.9, 20.9, 0),
              child: new Text(
                'Spokane',
                style: cityStyle(),
              )),
          new Container(
            alignment: Alignment.center,
            child: new Image.asset('assets/images/light_rain.png'),
          ),
          new Container(
            margin: EdgeInsets.fromLTRB(30.0, 200.0, 0, 0),
            alignment: Alignment.centerLeft,
            child: updateTempWidget("Weifang"),
          )
        ],
      ),
    );
  }
}

TextStyle cityStyle() {
  return new TextStyle(
      color: Colors.white, fontSize: 20.0, fontStyle: FontStyle.italic);
}

TextStyle tempStyle() {
  return new TextStyle(
      color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.w700);
}