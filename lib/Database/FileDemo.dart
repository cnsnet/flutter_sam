import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileDemo extends StatefulWidget {
  final String title;

  FileDemo({Key key, this.title}) : super(key: key);

  _FileDemoState createState() => _FileDemoState();
}

class _FileDemoState extends State<FileDemo> {
  var _enterDataField = new TextEditingController();
  String _savedData = "";

  // void _readData() async {
  //   stringRead = await readData();

  //   print(stringRead);
  // }

  @override
  void initState() {
    super.initState();

    _loadSavedData();

    //   stringRead = await readData();

    //   print(stringRead);
    //   // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   //   stringRead = await readData();
    //   // });
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      //_savedData = preferences.getString("data");

      if (preferences.getString("data") != null &&
          preferences.getString("data").isNotEmpty) {
        _savedData = preferences.getString("data");

        print(_savedData);
      }else{
        _savedData="Nothing.";
      }
    });
  }

  _saveData(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('data', message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: new Container(
        padding: EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: new Column(
          children: <Widget>[
            new TextField(
              controller: _enterDataField,
              decoration: new InputDecoration(labelText: "Enter text here."),
            ),
            new FlatButton(
              child: new Text("Save data"),
              onPressed: () {
                //writeData(_enterDataField.text);
                _saveData(_enterDataField.text);
              },
            ),
            new Padding(
              padding: EdgeInsets.all(15.0),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;

  return new File('$path/data.txt');
}

Future<File> writeData(String message) async {
  final file = await _localFile;

  print(message);

  return file.writeAsString('$message');
}

Future<String> readData() async {
  try {
    final file = await _localFile;
    String data = await file.readAsString();

    return data;
  } catch (e) {
    return "Read file error.";
  }
}
