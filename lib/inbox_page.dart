import 'package:flutter/material.dart';
import 'package:impulse_flutter_app/notifications_page.dart';
import 'package:impulse_flutter_app/record_video_page.dart';
import 'package:impulse_flutter_app/settings_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InboxPage extends StatefulWidget {

  InboxPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _InboxPageState(this.auth, this.onSignedOut, this.userId);
}

class _InboxPageState extends State<InboxPage> {

  final BaseAuth auth;
  final VoidCallback onSignedOut;

  _InboxPageState(this.auth, this.onSignedOut, this.userId);

  final String userId;

  final _textEditingController = TextEditingController();
  final _database = Firestore.instance.collection("users");

  final _conversationsDatabase = Firestore.instance.collection("conversations");

  @override
  Widget build(BuildContext context) {

    checkPermissions();

    var snapshots= Firestore.instance.collection("users").snapshots();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Impulse"),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            tooltip: 'Notifications',
            onPressed: _openNotifications,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: _openSettings,
          ),
        ],
      ),
      body: new StreamBuilder(
        stream: snapshots,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData)
            return new Text("No users found");
          return new GridView.extent(
              maxCrossAxisExtent: 220.0,
              children: _returnFriendTiles());
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showDialog(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        )
    );
  }

  List<InkWell> _returnFriendTiles() {
    //todo get friends from database
    var nrFriends = 10;
    List<String> listOfFriends = new List();
    listOfFriends.add("jakob");
    listOfFriends.add("matthijs");
    listOfFriends.add("rick");
    listOfFriends.add("carl");
    listOfFriends.add("sanne");
    listOfFriends.add("ana");
    listOfFriends.add("marcantoine");
    listOfFriends.add("yazhu");
    listOfFriends.add("anand");
    listOfFriends.add("dane");

    List<InkWell> containers = new List<InkWell>.generate(nrFriends,
      (int index) {
        return new InkWell(
        child: Container(
                child: new Text(
                  listOfFriends.elementAt(index),
                  textAlign: TextAlign.center
                ),
            ),
          onTap: _onFriendTap()
    );
   });
   return containers;
  }

  _onFriendTap() {

    //todo
  }
  _openSettings() {

    Navigator.push(context, new MaterialPageRoute(
        builder: (context) =>
        new SettingsPage(
          userId: userId,
          auth: auth,
          onSignedOut: onSignedOut,)
    ));
  }

  _openNotifications() {
    return new NotificationsPage(
      userId: userId,
      auth: auth,
      onSignedOut: onSignedOut,
    );
  }

  Future checkPermissions() async {
    PermissionStatus permissionCamera = await PermissionHandler().checkPermissionStatus(PermissionGroup.camera);
    PermissionStatus permissionMicrophone = await PermissionHandler().checkPermissionStatus(PermissionGroup.microphone);
    PermissionStatus permissionGallery = await PermissionHandler().checkPermissionStatus(PermissionGroup.mediaLibrary);

    if(permissionCamera == PermissionStatus.granted && permissionGallery == PermissionStatus.granted && permissionMicrophone == PermissionStatus.granted) {

    } else {
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.camera, PermissionGroup.microphone, PermissionGroup.mediaLibrary]);
    }
  }

  _typeMessage(BuildContext context, senderId, receiverId) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _sendMessage(_textEditingController.text.toString(), senderId, receiverId);
                    Navigator.pop(context);
                  })
            ],
          );
        }
    );

  }

  _sendMessage(String message, String senderId, String receiverId) {
    if (message.length > 0) {
      //_database.reference().child("todo").push().set(todo.toJson());
      _conversationsDatabase.add({
        "message": message,
        "senderId": senderId,
        "receiverId": receiverId,
        "timestamp": new DateTime.now().millisecondsSinceEpoch
      });
    }
  }

  _showDialog(BuildContext context) async {
    _textEditingController.clear();
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Row(
              children: <Widget>[
                new Expanded(child: new TextField(
                  controller: _textEditingController,
                  autofocus: true,
                  decoration: new InputDecoration(
                    labelText: 'Add new todo',
                  ),
                ))
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new FlatButton(
                  child: const Text('Save'),
                  onPressed: () {
                    _addEmail(_textEditingController.text.toString());
                    //Navigator.pop(context);
                    Navigator.push(context, new MaterialPageRoute(
                        builder: (context) =>
                        new CameraExampleHome ()
                    ));
                  })
            ],
          );
        }
    );
  }


  _addEmail(String todoItem) {
    if (todoItem.length > 0) {

      String email = todoItem.toString();
      //_database.reference().child("todo").push().set(todo.toJson());
      _database.add({
        "email": email
      });
    }
  }
}

