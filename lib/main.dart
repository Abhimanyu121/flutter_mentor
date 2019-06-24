import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    Login.tag:(context) =>Login(),
    Home.tag:(context) =>Home(),
    Register.tag:(context) => Register()
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
        buttonTheme:ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          padding: EdgeInsets.all(12),
          buttonColor: Colors.lightBlueAccent,
        )
      ),
      home: Register(),
      routes: routes,
    );
  }
}


