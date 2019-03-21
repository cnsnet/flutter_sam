import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter_sam/util/Models.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = new GoogleSignIn();

class FirebaseDemo extends StatefulWidget {
  final String title;

  FirebaseDemo({Key key, this.title}) : super(key: key);

  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DatabaseReference databaseReference;
  List<Board> boardMessages = List();

  Board board;

  // int _counter = 0;
  // void _incrementCounter() {
  //   database
  //       .reference()
  //       .child("message")
  //       .set({"firsename": "John", "lastname": "Zhang"});

  //   setState(() {

  //     database.reference().child("message").once().then((DataSnapshot snapshot){
  //       Map<dynamic,dynamic> data=snapshot.value;

  //       print("Value from db:${data.values}");
  //     });

  //     _counter++;
  //   });
  // }

  @override
  void initState() {
    super.initState();

    //_incrementCounter();

    board = new Board("subject", "body");
    databaseReference = database.reference().child("community_board");

    databaseReference.onChildAdded.listen(_onEntryAdded);
    databaseReference.onChildChanged.listen(_onEntryChanged);
  }

  void _onEntryAdded(Event event) {
    setState(() {
      boardMessages.add(Board.fromSnapshot(event.snapshot));
    });
  }

  void _handleSubmit() {
    final FormState form = formKey.currentState;

    if (form.validate()) {
      form.save();

      form.reset();

      //databaseReference.child("path").set(board.toJson());
      //databaseReference.update({"path": board.toJson()});
      databaseReference.push().set(board.toJson());
    }
  }

  _onEntryChanged(Event event) {
    var oldEntry = boardMessages.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });
    setState(() {
      boardMessages[boardMessages.indexOf(oldEntry)] =
          Board.fromSnapshot(event.snapshot);
    });
  }

  Future<FirebaseUser> _gSignin() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential authCredential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    FirebaseUser user = await _auth.signInWithCredential(authCredential);
    print("User: ${user.email}");
    
    return user;
  }

  _signInWithEmail() {
    _auth
        .signInWithEmailAndPassword(
            email: "zhang.ghost@gmail.com", password: "123456")
        .catchError((error) {
      print("Error: $error");
    }).then((newUser) {
      print("User: ${newUser.displayName}");
    });
  }

  Future _createUser() async {
    FirebaseUser user = await _auth
        .createUserWithEmailAndPassword(
            email: "zhang.ghost@gmail.com", password: "123456")
        .then((userNew) {
      print("User created ${userNew.displayName}");
      print("Email: ${userNew.email}");
    });

    return user;
  }

  _signOut() {
    setState(() {
      _googleSignIn.signOut();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            flex: 0,
            child: new Form(
              key: formKey,
              child: new Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  new ListTile(
                    leading: new Icon(Icons.subject),
                    title: new TextFormField(
                      initialValue: "",
                      onSaved: (val) => board.subject = val,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.message),
                    title: new TextFormField(
                      initialValue: "",
                      onSaved: (val) => board.body = val,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  new FlatButton(
                    color: Colors.blue,
                    child: new Text(
                      "Post",
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      _handleSubmit();
                    },
                  ),
                  new FlatButton(
                    child: new Text(
                      "Google Signin",
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _gSignin(),
                    color: Colors.blueAccent,
                  ),
                  new FlatButton(
                    child: new Text(
                      "Google Signin with Email",
                      style: new TextStyle(color: Colors.white),
                    ),
                    onPressed: () =>_signInWithEmail(),
                    color: Colors.blueAccent,
                  ),
                  new FlatButton(
                    child: new Text("Create Account",
                        style: new TextStyle(color: Colors.white)),
                    onPressed: () => _createUser(),
                    color: Colors.blueAccent,
                  ),
                  new FlatButton(
                    child: new Text("Signout",
                        style: new TextStyle(color: Colors.white)),
                    onPressed: () => _signOut(),
                    color: Colors.blueAccent,
                  )
                ],
              ),
            ),
          ),
          new Flexible(
            child: FirebaseAnimatedList(
              query: databaseReference,
              itemBuilder: (_, DataSnapshot snapshot,
                  Animation<double> animation, int idx) {
                return new Card(
                  child: new ListTile(
                    leading: new CircleAvatar(
                      backgroundColor: Colors.red,
                    ),
                    title: new Text(boardMessages[idx].subject),
                    subtitle: new Text(boardMessages[idx].body),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
