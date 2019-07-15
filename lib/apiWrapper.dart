import 'dart:convert';

import 'package:crypt/crypt.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import'listModel.dart';
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
  Future<dynamic> getTopics() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    String _uri = url+"get_topics";
    //String pass = new Crypt.sha256(password,salt:"qwertyuiop").toString();
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    var topics = await http.post(_uri,body: map);
    print(topics.body);
    var json = jsonDecode(topics.body);
    int i =0;
    print(json);
    print("wrapper");
    List list = new List();
    while(json[i.toString()]!=null){
      list.add(json[i.toString()]);
      //prefs.setString("topic"+i.toString(), json[i.toString()]);
      //print(prefs.getString("topic"+i.toString()));
      i++;
    }
    print(list);
    return list;
  }
  Future<bool>enroll(String topic)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    String _uri = url+"enroll";
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    map["topic_name"]= topic;
    var resp = await http.post(_uri,body: map);
    print(resp.body);
    if(resp.body == "True"){
      prefs.setBool("matching", true);
      prefs.setString("match_topic",topic);
      return true;
    }
    else
      return false;
  }
  Future<List> listMentor()async{
    String _uri = url+"getspMentor";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    var resp = await http.post(_uri,body: map);
    print(resp.body);
    List mlist = new List<listModel>();
    var json = jsonDecode(resp.body);
    int i = 0;
    while(json[i.toString()]!=null){
      listModel model= new listModel();
      model.email=json[i.toString()]["mentor"];
      model.topic=json[i.toString()]['topic'];
      mlist.add(model);
      i++;
    }
    return mlist;
  }
  Future<List> timeline(List mList,) async{
    String _uri = url+"get_timeline";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    List topic = new List<List>();
    for(int i = 0 ; mList[i]!=null;i++){
      map['topic_name']=mList[i]["topic"];
      var resp = await http.post(_uri,body: map);
      List time = new List();
      print(resp.body);
      var json = jsonDecode(resp.body);
      int j = 0;
      while(json[j.toString()]!=null) {
        time.add(json[j.toString()]['goal']);
        topic.add(time);
        j++;
      }
    }
  }
  Future<List> getphno(List mList)async{
    String _uri = url+"diffprofile";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    print(mList.length);
    for(int i = 0;i<mList.length;i++ ){
      map['new_email'] = mList[i].email;
      var resp = await http.post(_uri,body: map);
      print(resp.body);
      var json = jsonDecode(resp.body);
      mList[i].name = json['name'];
      mList[i].number= json['number'];
    }
    return mList;
  }
  Future<bool> enMentor() async{
    String _uri = url+"enrollment_status";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    var topic = prefs.getString("match_topic");
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    map["topic_name"]= topic;
    var resp = await http.post(_uri,body: map);
    print(resp.body);
    if (resp.body=="False"){
      return true;
    }else if (resp.statusCode!=200){
      return true;
    }
    else {
      prefs.setBool("matching", false);
      return false;
    }

  }
  Future<dynamic> getActive() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email");
    password = prefs.getString("password");
    String _uri = url+"get_applied";
    var map = new Map<String, dynamic>();
    map["email"]=email;
    map["password"]=password;
    var topics = await http.post(_uri,body: map);
    print(topics.body);
    var json = jsonDecode(topics.body);
    int i =0;
    print(json);
    print("wrapper");
    List list = new List();
    while(json[i.toString()]!=null){

      list.add(json[i.toString()]["topic_name"]);
      print("json print");
      print(json[i.toString()]["topic_name"]);
      //prefs.setString("topic"+i.toString(), json[i.toString()]);
      //print(prefs.getString("topic"+i.toString()));
      i++;
    }
    print(list);
    return list;
  }

}