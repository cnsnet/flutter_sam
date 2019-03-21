import 'package:firebase_database/firebase_database.dart';

class User {
  int _id;
  String _username;
  String _password;

  User(this._username, this._password);

  User.map(dynamic obj) {
    this._username = obj["username"];
    this._password = obj["password"];
    this._id = obj["id"];
  }

  String get username => _username;
  String get password => _password;
  int get id => _id;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map["username"] = _username;
    map["password"] = _password;

    if (id != null) {
      map["id"] = _id;
    }

    return map;
  }

  User.fromMap(Map<String, dynamic> map) {
    this._username = map["username"];
    this._password = map["password"];
    this._id = map["id"];
  }
}

class Board {
  String key;
  String subject;
  String body;
  Board(this.subject, this.body);

  Board.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        subject = snapshot.value["subject"],
        body = snapshot.value["body"];

  toJson() {
    return {"subject": subject, "body": body};
  }
}
