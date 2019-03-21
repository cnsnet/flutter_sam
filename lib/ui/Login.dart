import 'package:flutter/material.dart';
import '../weather/Weather.dart';

class Login extends StatefulWidget {
  final String title;
  Login({Key key, this.title}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  String _welcomeText = "";
  bool _showPassword=false;

  void _resetForm() {
      _usernameController.clear();
      _passwordController.clear();

    // setState(() {
    //   _usernameController.clear();
    //   _passwordController.clear();
    // });
  }

  // void _showWelcome() {
  //   if (_usernameController.text.isNotEmpty &&
  //         _passwordController.text.isNotEmpty) {
  //       _welcomeText = _usernameController.text;

  //       var router=new MaterialPageRoute(
  //         builder: (BuildContext context){
  //           return new Weather(title: "Weather",);
  //         }
  //       );

  //       Navigator.of(context).push(router);
  //     }else{
  //       _welcomeText="Nothing!";
  //     }
  //     setState(() {
        
  //     });
  //   // setState(() {
  //   //   if (_usernameController.text.isNotEmpty &&
  //   //       _passwordController.text.isNotEmpty) {
  //   //     _welcomeText = _usernameController.text;
  //   //   }else{
  //   //     _welcomeText="Nothing!";
  //   //   }
  //   // });
  // }

  Future _gotFromWeatherPage(BuildContext context) async{
    Map result=await Navigator.of(context).push(
      new MaterialPageRoute<Map>(
        builder: (BuildContext context){
          return new Weather(title: "Weather",);
        }
      )
    );

    if (result.containsKey("title"))
    {
      print(result["title"]);
    }
    else{
      print("Nothing......");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("Login"),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body: new Container(
        alignment: Alignment.topCenter,
        child: new ListView(
          children: <Widget>[
            new Image.asset(
              "assets/images/home.png",
              width: 100.0,
              height: 100.0,
            ),
            new Container(
              width: 380.0,
              height: 280.0,
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _usernameController,
                    decoration: new InputDecoration(
                        hintText: "Username", icon: new Icon(Icons.person)),
                  ),
                  new TextField(
                    obscureText: !_showPassword,
                    controller: _passwordController,
                    decoration: new InputDecoration(
                        hintText: "Password", icon: new Icon(Icons.lock)),
                  ),
                  new CheckboxListTile(
                    title: new Text("Show password"),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _showPassword,
                    onChanged: (bool){
                          this.setState((){
                            _showPassword=!_showPassword;
                          });
                        },
                  ),
                  new Padding(
                    padding: EdgeInsets.all(10.0),
                  ),
                  new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Column(
                        children: <Widget>[
                          new RaisedButton(
                            color: Colors.redAccent,
                            child: new Text(
                              "Login",
                              style: new TextStyle(color: Colors.white),
                            ),
                            onPressed: ()=>_gotFromWeatherPage(context),
                          )
                        ],
                      )),
                      new Expanded(
                          child: new Column(
                        children: <Widget>[
                          new RaisedButton(
                            color: Colors.redAccent,
                            child: new Text("Cancel",
                                style: new TextStyle(color: Colors.white)),
                            onPressed: _resetForm,
                          )
                        ],
                      ))
                    ],
                  )
                ],
              ),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  "Welcome, $_welcomeText",
                  style: new TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
