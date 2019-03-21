import 'package:flutter/material.dart';
import 'dart:math' as Math;

class BMI extends StatefulWidget {
  final String title;
  BMI({Key key, this.title}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return new BMIState();
  }
}

class BMIState extends State<BMI> {
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _weightController = new TextEditingController();
  int _heightRadioValue = 0;
  int _weightRadioValue = 0;
  String bmiFormattedString = "";
  String bmiResult = "";

  void _handleHeightRadio(int value) {
    _heightRadioValue = value;
    if (_heightRadioValue == 2)
      _weightRadioValue = 1;
    else
      _weightRadioValue = 0;

    setState(() {});
  }

  void _handleWeightRadio(int value) {
    _weightRadioValue = value;
    if (_weightRadioValue == 1)
      _heightRadioValue = 2;
    else
      _heightRadioValue = 0;

    setState(() {});
  }

  void _caculateBMI() {
    //var age = _ageController.text;
    var height = _heightController.text;
    var weight = _weightController.text;

    if (height.isNotEmpty && weight.isNotEmpty) {
      var bmi;
      debugPrint("Weight Radio Value:"+_weightRadioValue.toString());
      debugPrint("Height Radio Value:"+_heightRadioValue.toString());
      if (_weightRadioValue == 0) {
        bmi = 703 * double.parse(weight) / Math.pow(double.parse(height), 2);

        if (_heightRadioValue == 0) {
          bmi = bmi / 144;
        }
      } else {
        bmi = 10000*double.parse(weight) / Math.pow(double.parse(height), 2);
      }

      bmiFormattedString = "Your BMI:${bmi.toStringAsFixed(1)}";

      if (bmi < 18.5)
        bmiResult = "Underweight";
      else if (bmi >= 18.5 && bmi < 24.9)
        bmiResult = "Normal";
      else if (bmi >= 24.9 && bmi < 29.9)
        bmiResult = "Overweight";
      else if (bmi >= 29.9) bmiResult = "Obese";
    } else {
      bmiFormattedString = "Please input your height and weight.";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text(widget.title),
      ),
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Image.asset(
              "assets/images/bmilogo.png",
              width: 100.0,
              height: 100.0,
            ),
            new Container(
                width: 380.0,
                height: 360.0,
                color: new Color.fromARGB(255, 224, 224, 224),
                padding: EdgeInsets.all(10.0),
                child: new Column(
                  children: <Widget>[
                    new TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: "Age",
                          icon: new Icon(Icons.person_outline),
                          hintText: "Age"),
                    ),
                    new TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: "Height",
                          icon: new Icon(Icons.assessment),
                          hintText: "Height"),
                    ),
                    new Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(left: 30.0),
                        ),
                        new Radio(
                          value: 0,
                          groupValue: _heightRadioValue,
                          onChanged: _handleHeightRadio,
                        ),
                        new Text("Feet"),
                        new Radio(
                          value: 1,
                          groupValue: _heightRadioValue,
                          onChanged: _handleHeightRadio,
                        ),
                        new Text("Inches"),
                        new Radio(
                          value: 2,
                          groupValue: _heightRadioValue,
                          onChanged: _handleHeightRadio,
                        ),
                        new Text("Centimeters")
                      ],
                    ),
                    new TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                          labelText: "Weight",
                          icon: new Icon(Icons.line_weight),
                          hintText: "Weight"),
                    ),
                    new Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(left: 30.0),
                        ),
                        new Radio(
                          value: 0,
                          groupValue: _weightRadioValue,
                          onChanged: _handleWeightRadio,
                        ),
                        new Text("Lbs"),
                        new Radio(
                          value: 1,
                          groupValue: _weightRadioValue,
                          onChanged: _handleWeightRadio,
                        ),
                        new Text("Kilograms")
                      ],
                    ),
                    new Padding(padding: EdgeInsets.only(top: 10.0)),
                    new RaisedButton(
                      onPressed: _caculateBMI,
                      color: new Color.fromARGB(255, 255, 64, 129),
                      child: new Text(
                        "Caculate",
                        style: new TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                )),
            new Center(
              child: new Text(
                bmiFormattedString,
                style: new TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
            new Center(
              child: new Text(bmiResult,
                  style: new TextStyle(
                      color: new Color.fromARGB(255, 255, 64, 129),
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0)),
            )
          ],
        ),
      ),
    );
  }
}
