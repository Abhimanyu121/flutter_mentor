import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Database.dart';
import 'DbAdapter.dart';
import 'apiWrapper.dart';
import 'register.dart';

class Login extends StatefulWidget{
  static String tag = 'login-page';
  @override
  _loginPageState createState() => new _loginPageState();
}
 class _loginPageState extends State<Login>{
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var _email = new TextEditingController();
  var _password = new TextEditingController();
  bool loggin = false;
  @override
  Widget build(BuildContext context) {
    Widget loading = SpinKitFoldingCube(color: Colors.black54, size: 70);

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _email,
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
      controller: _password,
    );
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onPressed: (){
          _login();
        },
        padding: EdgeInsets.all(12),
        color: Colors.blueAccent,
        child: Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );
    final register = Padding (
      padding: EdgeInsets.symmetric(vertical: 9.0),
      child: FlatButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Register()),
        );
      },
          child: Text("Register"),
      ),
    );
    // TODO: implement build
    return Scaffold(
      key:_scaffoldKey,
      backgroundColor: Colors.white,
      body: Center(
        child:  loggin?loading: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            SizedBox(height: 8.0),
            register,
          ],
        ),
      ),
    );

  }
  _login() async {

    setState(() {
      loggin =true;
    });
    final database = await $FloorAppDatabase
        .databaseBuilder('mentordb.db')
        .build();
    final active = database.activeDao;
    final unSelected = database.unSelectedDao;
    ApiWrapper wrapper = new ApiWrapper();
    int resp =await wrapper.LoginRoute(_email.text, _password.text);
    if(resp==1){
      setState(() {
        loggin =false;
      });
      await wrapper.getActive().then((ls){
        for(int i =0; i<ls.length;i++){

          active.insertTopic(Active(ls[0].toString()));
          unSelected.insertTopic(UnSelected(ls[0].toString()));

          active.findActiveById(ls[0].toString()).then((value) {
            print("dblog");
            print(value.topic);
          });

        }
        active.findAllActive().then((value){
          print(value);
        });
      });

      Navigator.of(context).pushNamedAndRemoveUntil('/home', ModalRoute.withName('/login'));
    }
    if(resp==2){
      setState(() {
        loggin =false;
      });
      final snackBar = SnackBar(content: Text("Wrong email or password"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    if(resp ==3){
      setState(() {
        loggin =false;
      });
      final snackBar = SnackBar(content: Text("Wrong email or password"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }


  }
}