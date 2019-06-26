import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class ApiWrapper {
  String email;
  String name;
  String city;
  String number;
  String password;
  String interest;

  final  url = "http://nursery-varsity.herokuapp.com/";
  Future<bool> register(String email, String name, String number, String interests, String password, String city , String college,String gender) async{
    String pass = new Crypt.sha256(password,salt:"qwertyuiop").toString();
    var  _url = "https://nursery-varsity.herokuapp.com/register";
    var map  = new Map<String, dynamic>();
    map["email"]=email;
    map["number"]=number;
    map["interest"]=interests;
    map["password"]=pass;
    map["location"]=city;
    map["name"]=name;
    map["gender"]=gender;
    map["college"]=college;
    var response = await http.post(_url,body: map);
    print(response.body.toString());
    if (response.body.toString()=="ok"){
      return true;
    }else{
      return false;
    }

  }
  Future<int> LoginRoute(String email, String password)async{
   var _url = url+"login";
   var pro_url=url+"profile";
   String pass = new Crypt.sha256(password,salt:"qwertyuiop").toString();
   var map = new Map<String, dynamic>();
   map["email"]=email;
   map["password"]=pass;
   var response = await http.post(_url,body: map);
   var profile = await http.post(pro_url,body: map);
   if (profile.statusCode==200){
      print(profile.body.toString());
      var pjson=jsonDecode(profile.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("email", pjson['email']);
      await prefs.setString("password", pass);
      await prefs.setString("name", pjson['email']);
      await prefs.setString("number", pjson['number']);
      await prefs.setString("interest", pjson['interest']);
      await prefs.setString("college", pjson['college']);
      await prefs.setString("gender", pjson['gender']);
      await prefs.setString("mentor", pjson['mentor']);
      await prefs.setString("location", pjson['location']);
      await prefs.setBool("status", true);
      print(prefs.getString('email'));
   }


   print(response.body);
   if (response.body =="True"){
     return 1;
   }
   else if(response.body!="True"&& response.statusCode==200){
     return 2;
   }
   else{
     return 3;
   }
  }
}