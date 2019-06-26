import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget{

  _profile_ui createState() => new _profile_ui();
}
class _profile_ui extends State<Profile>{
  Map data=new Map<String, dynamic>();
  _init(){
    data['email']="loading";
    data['name']="loading";
    data['number']="loading";
    data['city']="loading";
    data['interest']="loading";
    data['college']="loading";
    data['gender']="loading";
  }
  Future<dynamic> getProfile()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map map = new Map<String, dynamic>();
    map['email']=prefs.getString("email");
    map['name']=prefs.getString("name");
    map['college']=prefs.getString("college");
    map['interest']=prefs.getString("interest");
    map['city']=prefs.getString("location");
    map['number']=prefs.getString("number");
    map['gender']=prefs.getString("gender");
    return map;
  }
  @override
  void initState() {
    _init();
    getProfile().then((value){
      setState(() {
        data = value;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    print("called");
    return new ListView(
      children: <Widget>[
        Container(
            child: Text("PERSONAL DETAILS",style: TextStyle(fontWeight:FontWeight.bold,),)),
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                Text(data['name']),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Text("Gender",style: TextStyle(fontWeight: FontWeight.bold),),
                Text(data['gender']),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                  Text("College",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(data['college'],textAlign: TextAlign.right,)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: <Widget>[
                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(width:150,child: Text(data['email'],textAlign: TextAlign.right,maxLines: 5,overflow: TextOverflow.ellipsis,)),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween
            ),
          ),
        ),
        Container(
            child: Text("OTHER INFORMATION",style: TextStyle(fontWeight:FontWeight.bold,),)),
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: <Widget>[
                  Text("Areas of intrest",style: TextStyle(fontWeight: FontWeight.bold),),
                  Container(
                    width: 150,
                    child: Text(data['interest'],textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis, maxLines: 5),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                children: <Widget>[
                  Text("Location",style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(data['city']),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            onPressed: () {
              //Navigator.of(context).pushNamed(HomePage.tag);
            },
            padding: EdgeInsets.all(12),
            color: Colors.blueAccent,
            child: Text('Update Profile', style: TextStyle(color: Colors.white)),
          ),
        )
      ],
    );
  }

}