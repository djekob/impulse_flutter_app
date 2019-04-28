import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'upload.dart';
import 'package:flutter/material.dart';
import 'login_signup_page.dart';
import 'authentication.dart';
import 'inbox_page.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class ChangeProfilePictureScreen extends StatefulWidget {
  ChangeProfilePictureScreen({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _ChangeProfilePictureScreenState(key, auth, userId);
}

class _ChangeProfilePictureScreenState extends State<ChangeProfilePictureScreen> {

  _ChangeProfilePictureScreenState(Key key, this.auth, this.userId);
  final BaseAuth auth;
  final String userId;
  File _image;
  var image;

  final _database = Firestore.instance.collection("users");


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Profile picture"),
        ),
        body: new Column(
          children: <Widget>[
            Container(
              child: displayProfileImage()
            ),
            new Row(
                children: <Widget> [

                  new FlatButton(
                    onPressed: openGallery,
                    child: new Text("From gallery"),
                  ),
                  new FlatButton(
                      onPressed: openCamera,
                      child: new Text("Take picture"))

                  ]
            )
          ],
        )
        );
  }

  Future openGallery() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      Upload uploadTask = new Upload();

      String filename = userId + DateTime.now().millisecondsSinceEpoch.toString();
      uploadTask.uploadFile(filename, _image.path, "image", "jpg");
      _database.where("userId", );
    });
  }

  Future openCamera() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      Upload uploadTask = new Upload();

      String filename = userId + DateTime.now().toIso8601String();
      uploadTask.uploadFile(filename, _image.path, "image", "jpg");
      

    });
  }

  Widget displayProfileImage() {

    if(_image == null) {
      return Image.asset("assets/profile-png-icon-1.jpg", height: 240,);
    } else {
      return Image.file(_image, height: 240);
      }
  }


}