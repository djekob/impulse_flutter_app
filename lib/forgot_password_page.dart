import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:impulse_flutter_app/user.dart';
import 'authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key key, this.auth})
      : super(key: key);

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  String _email;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text("Forgot password")
      ),
      body: Center(
        child: new ListView(
          children: <Widget>[
            new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: new InputDecoration(
                  hintText: 'Email',
                  icon: new Icon(
                    Icons.mail,
                    color: Colors.grey,
                  )),
              validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
              onSaved: (value) => _email = value,
            ),
            new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.blue,
              child: new Text('Send password reset mail',
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              //onPressed: _sendForgotPasswordEmail(),
              onPressed: null,
            )
          ],
        )
      ),
    );
  }


}