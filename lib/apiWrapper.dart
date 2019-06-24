import 'package:crypt/crypt.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
   String pass = new Crypt.sha256(password,salt:"qwertyuiop").toString();
   var map = new Map<String, dynamic>();
   map["email"]=email;
   map["password"]=pass;
   var response = await http.post(_url,body: map);
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