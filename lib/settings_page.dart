import 'package:flutter/material.dart';
import 'login_signup_page.dart';
import 'authentication.dart';
import 'home_page.dart';
import 'inbox_page.dart';
import 'dart:async';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Impulse"),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: _signOut,
              )
            ]
        ),
      body: Center(
        child: new Text("dit is gewoon een tekst"
        ),
      ),
    );
  }




  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
      Navigator.of(context).pop();
      //Navigator.of(context).pushNamedAndRemoveUntil("/root", (Route<dynamic> route) => false);
    } catch (e) {
      print(e);
    }
  }

}