import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user.dart';
import 'upload.dart';
import 'package:flutter/material.dart';
import 'login_signup_page.dart';
import 'authentication.dart';
import 'inbox_page.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';

class ChangeProfilePictureScreen extends StatefulWidget {
  ChangeProfilePictureScreen({Key key, this.auth, this.userId, this.onSignedOut, this.user})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;
  final User user;

  @override
  State<StatefulWidget> createState() => new _ChangeProfilePictureScreenState(key, auth, userId, user);
}

class _ChangeProfilePictureScreenState extends State<ChangeProfilePictureScreen> {

  _ChangeProfilePictureScreenState(Key key, this.auth, this.userId, this.user);
  final BaseAuth auth;
  final String userId;
  final User user;
  File _image;
  var image;
  String downloadLinkUrl;

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
      UploadDownload uploadTask = new UploadDownload();

      String filename = userId + DateTime.now().millisecondsSinceEpoch.toString();
      uploadTask.uploadFile(filename, _image.path, "image", "jpg");

      _database.where('uid', isEqualTo: userId).getDocuments().then(
              (data) {
            _database.document(data.documents[0].documentID).updateData({'profilePictureUrl': filename});
          }
      );
    });
  }

  Future openCamera() async {
    image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
      UploadDownload uploadTask = new UploadDownload();

      String filename = userId + DateTime.now().millisecondsSinceEpoch.toString();
      uploadTask.uploadFile(filename, _image.path, "image", "jpg");

      _database.where('uid', isEqualTo: userId).getDocuments().then(
          (data) {
            _database.document(data.documents[0].documentID).updateData({'profilePictureUrl': filename});
          }
      );
    });
  }

  Future downloadProfilePic() async {
    UploadDownload uploadDownload = new UploadDownload();
    var _downloadLinkUrl = await uploadDownload.downloadFile(user.profilePictureUrl);

    setState(() {
      downloadLinkUrl = _downloadLinkUrl;
    });
  }

  Widget displayProfileImage() {
    if(_image == null && downloadLinkUrl == null) {
      return Image.asset("assets/profile-png-icon-1.jpg", height: 240,);
    } else if(downloadLinkUrl == null) {
      return Image.network(downloadLinkUrl);
    } else {
      //Image.network(_image, height: 240);
      return Image.file(_image, height: 250);
    }
  }


}