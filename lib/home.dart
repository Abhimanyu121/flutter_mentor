import 'package:flutter/material.dart';

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
  bool index1 = true;
  bool index2 = false;
  bool index3 = false;
  bool index4 = false;
  bool index5 =false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: (index1 ? profile : (index2 ? list_tab : (index3 ? list_tab : (index4 ? list_tab:(index5 ? list_tab:list_tab) )))),
      appBar: AppBar(elevation: 0,shape: RoundedRectangleBorder(),centerTitle: true,title:Text("Home"),backgroundColor: Colors.blue,),
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            IconButton(
              icon: Icon(Icons.stars),
              color: (index4? Colors.red : Colors.black),
              onPressed: () {
                _onTap(4);
              },
            ),
            IconButton(
              icon: Icon(Icons.timelapse),
              color: (index5 ? Colors.red : Colors.black),
              onPressed: () {
                _onTap(5);
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