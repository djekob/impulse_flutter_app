import 'package:flutter/material.dart';
import 'package:impulse_flutter_app/user.dart';
import 'authentication.dart';
import 'change_profile_picture_screen.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.auth, this.userId, this.onSignedOut, this.user})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final User user;

  @override
  State<StatefulWidget> createState() => new _SettingsPageState(key, auth, userId, user);
}

class _SettingsPageState extends State<SettingsPage> {

  _SettingsPageState(Key key, this.auth, this.userId, this.user);

  final BaseAuth auth;
  final String userId;
  final User user;

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
      body: new ListView(
        children: <Widget> [
          ListTile(
            title: Text("Change profile picture"),
            onTap: () {
              _changeProfilePictureScreen();
            },
          ),
          new Text("Made with love"),
      ],
    ));
  }



  _changeProfilePictureScreen() {
    print("OnTap: Change profile picture screen");

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ChangeProfilePictureScreen(
              userId: userId,
              auth: auth,
              user: user,
          )
    ));

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