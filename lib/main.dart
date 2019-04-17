import 'package:flutter/material.dart';
import 'package:impulse_flutter_app/authentication.dart';
import 'package:impulse_flutter_app/inbox_page.dart';
import 'package:impulse_flutter_app/settings_page.dart';
import 'root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Impulse',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: <String, WidgetBuilder> {
          '/root': (BuildContext context) => new RootPage(auth: new Auth()),
        }
        , home: new RootPage(auth: new Auth()));
  }
}
