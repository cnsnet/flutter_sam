import 'package:flutter/material.dart';

class WeightOnPlanet extends StatefulWidget {
  final String title;
  WeightOnPlanet({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new WeightOnPlanetState();
  }
}

class WeightOnPlanetState extends State<WeightOnPlanet> {
  final TextEditingController _inputWeightController =
      new TextEditingController();
  int _radioValue = 0;
  String _finalFormattedWeight;

  void handleRadioValueChanged(int value) {
    if(_inputWeightController.text.isEmpty) return;

    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          _finalFormattedWeight = caculateWeight(_inputWeightController.text, 0.06).toStringAsFixed(1);

          break;
        case 1:
          _finalFormattedWeight = caculateWeight(_inputWeightController.text, 0.38).toStringAsFixed(1);

          break;
        case 2:
          _finalFormattedWeight = caculateWeight(_inputWeightController.text, 0.91).toStringAsFixed(1);

          break;
        default:
          break;
      }
    });
  }

  double caculateWeight(String weight, double multiplier) {
    return double.parse(weight) * multiplier;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: new Text(widget.title),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          padding: new EdgeInsets.all(2.5),
          children: <Widget>[
            new Image.asset(
              "assets/images/planet.png",
              color: Colors.blue,
              width: 100.0,
              height: 100.0,
            ),
            new Container(
              margin: EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _inputWeightController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                        labelText: "Ur weight on earth",
                        hintText: "In bounds",
                        icon: new Icon(Icons.person_outline)),
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: handleRadioValueChanged),
                      new Text("Pluto"),
                      new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: handleRadioValueChanged),
                      new Text("Mars"),
                      new Radio(
                          value: 2,
                          groupValue: _radioValue,
                          onChanged: handleRadioValueChanged),
                      new Text("Venus"),
                    ],
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(10.0),
                  ),
                  new Text(_inputWeightController.text.isEmpty?"Please input weight.":_finalFormattedWeight)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
