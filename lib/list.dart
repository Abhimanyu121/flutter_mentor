import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mentor_app/Database.dart';

import 'apiWrapper.dart';
class List_tab extends StatefulWidget {
  _list_ui createState() => new _list_ui();

}
class _list_ui extends State<List_tab>{
  List mentors;
  List full;
  bool matching=false;
  bool nothing= false;
  ApiWrapper wrapper = new ApiWrapper();
  _checkMatch(List mList)async{
    try{
      final database = await $FloorAppDatabase.databaseBuilder('mentordb.db').build();
      for(int i = 0; i<mList.length;i++){
        database.unSelectedDao.deleteUnSelectedWithId(mList[i].topic);
      }
      database.unSelectedDao.findAllUnSelected().then((val){
        if(val.length!=0){
          setState(() {
            matching=true;
          });

        }
      });
    }
    catch(e){}
  }
  _mentorList () async {
    return await wrapper.listMentor();
  }
  _getTimeline(List mList) async {
    return await wrapper.timeline(mList);
  }
  _getNumber(List mList) async {
    return  await wrapper.getphno(mList);
  }
  @override
  void initState() {
    _mentorList().then((mentors){
      _getNumber(mentors).then((number){
        setState(() {

          this.mentors= number;
        });
        _checkMatch(number);
        if (number.length==0){
          setState(() {
            nothing=true;
          });
        }
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return (mentors==null)?_loader():nothing?_nothing():_explist();
  }
  _loader(){
    return new SpinKitWanderingCubes(color: Colors.black, size: 50,);
  }
  _explist(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
              itemCount: mentors.length,
              itemBuilder: (context , position){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(10),
                    child: new ExpansionTile(
                      title: Text(mentors[position].topic, style: TextStyle(fontWeight: FontWeight.bold),),
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(mentors[position].name)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(mentors[position].email)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Number",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text(mentors[position].number)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
        matching ? SpinKitWanderingCubes(size: 20,color: Colors.black,):Text(""),
        matching ? Text("Matching you with some mentors", style: TextStyle(fontWeight: FontWeight.w100),):Text(""),
      ],
    );
  }
  _nothing(){

    return Center(child: Text("Nothing here yet!", style: TextStyle(fontWeight: FontWeight.bold),));
  }

}