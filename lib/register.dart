import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'apiWrapper.dart';
import 'exceptionHandler.dart';
import 'login.dart';
class Register extends StatefulWidget{
  static String tag = 'register-page';
  @override
  _registerPageState createState() => new _registerPageState();
}
class _registerPageState extends State<Register>{


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int index;
  int selectedradio;
  bool _load= false;
  var _email = new TextEditingController();
  var _number = new TextEditingController();
  var _name = new TextEditingController();
  var _interest= new TextEditingController();
  var _city = new TextEditingController();
  var _password = new TextEditingController();
  var _confirm= new TextEditingController();
  var _college= new TextEditingController();
  String gender="male";
  @override
  void initState(){
    super.initState();
    selectedradio = 0;
  }
  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator =_load? new Container(
      color: Colors.grey[300],
      width: 70.0,
      height: 70.0,
      child: new Padding(padding: const EdgeInsets.all(5.0),child: new Center(child: new CircularProgressIndicator())),
    ):new Container();
    Widget center = new Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 24.0, right: 24.0),
        children: <Widget>[
          Hero(
            tag: 'hero',
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 48.0,
              child: Image.asset('assets/logo.png'),
            ),
          ),
          SizedBox(height: 48.0),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _email,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            keyboardType: TextInputType.number,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Phone number',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _number,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Name',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _name,
          ),
          SizedBox(height: 8.0),
          new RadioListTile(
            value: 0,
            groupValue: selectedradio,
            selected: true,
            title: Text("Male"),
            onChanged: _setMale() ,
            activeColor: Colors.blue,

          ),
          new RadioListTile(
            activeColor: Colors.blue,
            value: 1,
            groupValue: selectedradio,
            title: Text("Female"),
            onChanged: _setFemale(),
          ),
          SizedBox(height: 8.0),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'City',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _city,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'College',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _college,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            keyboardType: TextInputType.text,
            autofocus: false,
            decoration: InputDecoration(
              hintText: 'Intrested fields',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _interest,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _password,
          ),
          SizedBox(height: 8.0),
          TextFormField(
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
            controller: _confirm,
          ),
          SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: () {
                _register(context);
              },
              padding: EdgeInsets.all(12),
              color: Colors.blueAccent,
              child: Text('Register', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 8.0),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 9.0),
            child: FlatButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
              child: Text("Login"),
            ),
          ),
          //new Align(child: loadingIndicator,alignment: FractionalOffset.center,),
        ],
      ),
    );
    Scaffold scaffold = new Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: ModalProgressHUD(child: center, inAsyncCall: _load)

    );
    return scaffold;
  }
  _register(BuildContext context) async {
   // setState(() {
     // _load=true;
    //});

    String error;
    exceptionHandler handler = new exceptionHandler();
    int i = handler.register(_email.text, _name.text, _number.text, _interest.text, _password.text, _city.text,_confirm.text);
    switch(i){
      case 1: error = "Invalid Email"; print("here");break;
      case 2: error = "Invalid Name";break;
      case 3: error = "Invalid phone number"; break;
      case 4: error = "Password must be longer than 6 characters"; break;
      case 5: error = "Invalid city"; break;
      default:error = "No error";
    }
    if (i == 0){
      ApiWrapper wrapper = new ApiWrapper();
      bool flag=await wrapper.register(_email.text, _name.text, _number.text, _interest.text, _password.text, _city.text,_college.text, gender);
      if(flag){
        _load=false;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );

      }
      else{

        setState(() {
          _load=false;
        });
        final snackBar = SnackBar(content: Text("Something went wrong"));
        _scaffoldKey.currentState.showSnackBar(snackBar);
      }
    }else {

      setState(() {
        _load=false;
      });
      final snackBar = SnackBar(content: Text(error));
      _scaffoldKey.currentState.showSnackBar(snackBar);

     }

  }
  _setMale(){
    setState(() {
      selectedradio=0;
    });
    gender="male";
  }
  _setFemale(){
    setState(() {
      selectedradio=1;
    });
    gender="female";
  }

}
