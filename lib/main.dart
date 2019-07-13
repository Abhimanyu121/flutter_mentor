import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';
import 'login.dart';
import 'register.dart';
void main() async
{


  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  MyApp_ui createState()  => new MyApp_ui();

}

class MyApp_ui extends State<MyApp> {
  Widget currentWidget = Login();
  Future<dynamic> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('status');
  }
  @override
  void initState() {
    getUser().then((value) {
      if (value == null|| value ==false) {
        print(value.toString());
        setState(() {
          currentWidget = Login();
        });
      } else {
        print(value.toString());
        setState(() {
          currentWidget = Home();
        });
      }
    });
  }
  final routes = <String, WidgetBuilder>{
    "/login":(context) =>Login(),
    "/home":(context) =>Home(),
    "/register":(context) => Register(),
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
      home: currentWidget,
      routes: routes,
    );
  }
}


