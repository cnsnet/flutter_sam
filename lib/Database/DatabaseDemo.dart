import 'package:flutter/material.dart';
//import 'package:path_provider/path_provider.dart';

import '../util/DBHelper.dart';
import '../util/Models.dart';
import '../util/NoToDoHelper.dart';
import '../Database/NoDoItem.dart';

class DatabaseDemo extends StatefulWidget {
  final String title;

  DatabaseDemo({Key key, this.title}) : super(key: key);

  _DatabaseDemoState createState() => _DatabaseDemoState();
}

class _DatabaseDemoState extends State<DatabaseDemo> {
  var db = new NoToDoDBHelper();
  final List<NoDoItem> _list = <NoDoItem>[];
  // void _saveToDB() async {
  //   var db = new DBHelper();

  //   int savedUser = await db.saveUser(new User("Bond", "james"));

  //   print("User saved $savedUser");
  // }

  void _getAll() async {
    List items = await db.getAll();
    items.forEach((item) {
      setState(() {
        _list.add(NoDoItem.map(item));
      });
    });

    print(_list.length);
  }

  // void _getFromDB() async {
  //   var db = new DBHelper();

  //   // int savedUser = await db.saveUser(new User("Bond", "james"));
  //   // savedUser = await db.saveUser(new User("John", "james"));
  //   // savedUser = await db.saveUser(new User("Bob", "james"));
  //   // savedUser = await db.saveUser(new User("Kevin", "james"));
  //   // savedUser = await db.saveUser(new User("April", "james"));

  //   // print("User saved $savedUser");

  //   // int count=await db.getCount();
  //   // print("There are $count records in DB.");

  //   // User user = await db.getUser(1);
  //   // print("Username ${user.username}, User ID: ${user.id}");

  //   // int deletedUser=await db.deleteUser(1);
  //   // print("User deleted: $deletedUser");

  //   User toUpdate =
  //       User.fromMap({"username": "James", "password": "wolawola", "id": 1});
  //   await db.updateUser(toUpdate);
  // }

  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();

    _getAll();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //_saveToDB();
      //_getFromDB();
      //_getAllUsers();
    });
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();

    NoDoItem noDoItem = new NoDoItem(text, DateTime.now().toIso8601String());
    int savedItemId = await db.save(noDoItem);

    print("Saved Item id: $savedItemId");

    setState(() {
      _list.insert(0, noDoItem);
    });
  }

  void _showFormDialog() {
    var alert = new AlertDialog(
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "eg. Don't buy stuff.",
                  icon: new Icon(Icons.note_add)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            _handleSubmit(_textEditingController.text);
            _textEditingController.clear();
            Navigator.pop(context);
          },
          child: new Text("Save"),
        ),
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text("Calcel"),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _deleteNoDoItem(int id, int idx) async {
    await db.deleteModel(id);
    setState(() {
      _list.removeAt(idx);
    });
  }

  void _updateNoDoItem(NoDoItem item, int idx) async {
    var alert = new AlertDialog(
      title: new Text("Update Item"),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Item",
                  hintText: "Input text here.",
                  icon: new Icon(Icons.update)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () async {},
          child: new Text("Update"),
        ),
        new FlatButton(
          onPressed: () => Navigator.pop(context),
          child: new Text("Cancel"),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.redAccent,
        child: new ListTile(
          title: new Icon(Icons.add),
        ),
        onPressed: _showFormDialog,
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: _list == null ? 0 : _list.length,
              padding: EdgeInsets.all(8.0),
              reverse: false,
              itemBuilder: (_, int idx) {
                return new Card(
                  color: Colors.white10,
                  child: new ListTile(
                    title: _list[idx],
                    onLongPress: () => _updateNoDoItem(_list[idx], idx),
                    trailing: new Listener(
                      key: new Key(_list[idx].itemName),
                      child: new Icon(Icons.remove_circle,
                          color: Colors.redAccent),
                      onPointerDown: (pointerEvent) =>
                          _deleteNoDoItem(_list[idx].id, idx),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
      // body: new ListView.builder(
      //   itemCount: _list ==null?0:_list.length,
      //   itemBuilder: (_,int idx){
      //     return new NoDoItem(NoDoItem.fromMap(_list[idx]).itemName, NoDoItem.fromMap(_list[idx]).dateCreated);
      //   },
      // )
    );
  }
}
