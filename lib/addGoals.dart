import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentor_app/Database.dart';
import 'package:toast/toast.dart';

import 'DbAdapter.dart';
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
  static bool present=false;
  static bool error= false;
  List ls;
 // SharedPreferences prefs;
  _fetchData() async {
    ApiWrapper wrapper= new ApiWrapper();
    return await wrapper.getTopics();
  }
  _checkMatch()async {
    final database = await $FloorAppDatabase
        .databaseBuilder('mentordb.db')
        .build();
    var active= database.activeDao;
    return await active.findAllActive();
  }

  @override
  void initState() {
    try{
    _initial();
    }
    catch(e){
      setState(() {
        error= true;
      });
    }



  }
  //find workaround to get these initialized on call only

  @override
  Widget build(BuildContext context) {
    return error?_error():(list==null)?_loader():load? _loader():_view();
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
                present =false;
                try{
                  for(int i = 0; i<ls.length;i++){
                    if(ls[i].topic==list[pos]){
                      present =true;
                      break;
                    }
                  }
                }catch(e){}

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
                          color: present?Colors.blueGrey:position % 2 == 0 ? Colors.deepOrange : Colors.teal,
                          child: present?Center(child: Text(list[position]+"\n\n\n Already Chosen",textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold),)):Center(child: Text(list[position],textAlign: TextAlign.center, style:TextStyle(fontWeight: FontWeight.bold),)),
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
                if(present){
                  Toast.show("Topic Already Chosen", context,duration:Toast.LENGTH_LONG);
                }else{
                _enroll();
                  }
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
    final database = await $FloorAppDatabase
        .databaseBuilder('mentordb.db')
        .build();
    var active= database.activeDao;
    var unSelected = database.unSelectedDao;
    unSelected.insertTopic(UnSelected(list[pos]));
    active.insertTopic(Active(list[pos]));
    _initial();
    setState(() {
      load=false;
    });

  }
  else {
    setState(() {
      load=false;
    });
    Toast.show("Something Went Wrong", context,duration: Toast.LENGTH_LONG);
  }

}
_error(){
    String val = "Check your internet!";
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.error,color: Colors.black,size: 50,),
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text(val, textAlign: TextAlign.center)),
          ),
          Padding(

            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
                color:Colors.blue,
                onPressed: (){_initial();},
                child: Text("Try Again",style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );

}
_initial(){
  _fetchData().then((value){
    _checkMatch().then((val){
      setState(() {
        ls = val;
        list = value;

      });
    });

  });
}

}