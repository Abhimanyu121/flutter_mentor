import 'package:flutter/material.dart';

import 'addGoals.dart';
import 'list.dart';
import 'profile.dart';
class Home extends StatefulWidget{
  static String tag = 'home-page';
  @override
  _home_ui createState() => new _home_ui();
  Widget body;
}
class _home_ui extends State<Home>{
  Profile profile = new Profile();
  List_tab list_tab = new List_tab();
  addGoals newGoals = new addGoals();
  bool index1 = true;
  bool index2 = false;
  bool index3 = false;
  bool index4 = false;
  bool index5 =false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.0),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: (index1 ? profile : (index2 ? list_tab :  newGoals )) ,
              )
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        shape: RoundedRectangleBorder(),
        //centerTitle: true,
        title:(index1 ? Text("Profile") : (index2 ? Text("List of Mentors") : (index3 ? Text("Add Goals") : (index4 ? Text("List Of Goals"):(index5 ? Text("Timeline for Goals"):Text("")) )))),
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            onPressed: (){},
          ),
          FlatButton(
            child: Icon(
              Icons.account_circle,
              color: Colors.black,
            ),
            onPressed: (){_onTap(1);},
          )
        ],
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.blue,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){_onTap(3);},
        backgroundColor: Colors.red,
        child:  Icon(
          (index3 ? Icons.clear:Icons.add),
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            IconButton(
              icon: Icon(Icons.perm_identity),
              color: (index1? Colors.red : Colors.black),
              onPressed: () {
                _onTap(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.menu),
              color: (index2? Colors.red : Colors.black),
              onPressed: () {
                _onTap(2);
              },
            ),

          ],
        ),
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 2.0,
      ),

    );
  }
  void _onTap(int index){
    setState(() {
      if (index ==1){
        index2= false;
        index1 = true;
        index3 = false;
        index4 = false;
        index5 = false;
      }else if (index ==2){
        index2= true;
        index1 = false;
        index3 = false;
        index4 = false;
        index5 = false;
      } else if (index ==3){
        index2= false;
        index1 = false;
        index3 = true;
        index4 = false;
        index5 = false;
      }
      else if (index ==4){
        index2= false;
        index1 = false;
        index3 = false;
        index4 = true;
        index5 = false;
      }
      else if (index ==5){
        index2= false;
        index1 = false;
        index3 = false;
        index4 = false;
        index5 = true;
      }
    });

  }
}