import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'apiWrapper.dart';
bool new_topic = false;
class addGoals extends StatefulWidget{
  _add_goals createState() => new _add_goals();
}
class _add_goals extends State<addGoals>{
  static int pos =0;
  static int state=0;
  static List list;
  static bool match=true;
  static bool load = false;
  static String mTopic;
 // SharedPreferences prefs;
  _fetchData() async {
    ApiWrapper wrapper= new ApiWrapper();
    return await wrapper.getTopics();
  }
  _checkMatch()async {
    ApiWrapper wrapper = new ApiWrapper();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("matching")){
      mTopic =  prefs.getString("match_topic");
      print(mTopic);
      return await wrapper.enMentor();
  }
    else
      return false;
  }
  @override
  void initState() {
    match =false;
    _fetchData().then((value){
      setState(() {
        list = value;
      });
    });
    _checkMatch().then((value){
      setState(() {
        if(value)
          match=value;
        else
          match =false;
      });
    });
  }
  //find workaround to get these initialized on call only

  @override
  Widget build(BuildContext context) {
    return (list==null)? _loader():match?_matching():_view();
  }
_loader(){
    return new SpinKitFoldingCube(color: Colors.blue,size: 25.0,);
}
_view(){
  print(list.length);
    return new Column(
      children: <Widget>[
        Text("CHOOSE A TOPIC",style: TextStyle(fontWeight: FontWeight.bold),),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PageView.builder(
              itemCount: list.length,
              itemBuilder: (context, position){
                pos = position;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Icon(
                      (position==0)?null: Icons.arrow_back,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        width:250,
                        child: Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          color: position % 2 == 0 ? Colors.deepOrange : Colors.teal,
                          child: Center(child: Text(list[position],textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold),)),
                        ),
                      ),
                    ),
                    Icon(
                        (position==list.length-1)? null:Icons.arrow_forward
                    )
                  ],
                );

              },
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
        ),
        SizedBox(
          width:200,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              onPressed: (){
                _enroll();
              },
              padding: EdgeInsets.all(12),
              color: Colors.red,
              child: Text('Select Topic', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),

      ],
    );
}
_enroll()async{
  ApiWrapper wrapper= new ApiWrapper();
  setState(() {
    load =true;
  });
  bool stat = await wrapper.enroll(list[pos]);
  if (stat){
    setState(() {
      match=true;
    });
  }
  else {
    Toast.show("Something Went Wrong", context,duration: Toast.LENGTH_LONG);
  }
}
_matching(){
    String val = "Hold on tight while we find you a mentor. ";
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SpinKitWanderingCubes(color: Colors.black,size: 90,),
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(val, textAlign: TextAlign.center)),
          )
        ],
      ),
    );
}

}