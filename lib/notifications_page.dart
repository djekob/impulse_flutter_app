import 'package:flutter/material.dart';
import 'login_signup_page.dart';
import 'authentication.dart';
import 'inbox_page.dart';

class NotificationsPage extends StatefulWidget {
  NotificationsPage({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _NotificationsPageState();
}

class _NotificationsPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }


}