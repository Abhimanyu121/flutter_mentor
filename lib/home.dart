import 'package:flutter/material.dart';

import 'profile.dart';
class Home extends StatefulWidget{
  static String tag = 'home-page';
  @override
  _home_ui createState() => new _home_ui();
  Widget body;
}
class _home_ui extends State<Home>{
  bool index1 = true;
  bool index2 = false;
  bool index3 = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: (index1? (index2 ? (index3? new Profile(): new Profile()) : new Profile()): new Profile()),
      appBar: AppBar(elevation: 0,shape: RoundedRectangleBorder(),centerTitle: true,title:Text("Home"),backgroundColor: Colors.blue,),
      backgroundColor: Colors.blue,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){_onTap(2);},
        backgroundColor: Colors.red,
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      bottomNavigationBar: BottomAppBar(

        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              color: Colors.black,
              onPressed: () {
                _onTap(1);
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.black,
              onPressed: () {
                _onTap(3);
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
      }else if (index ==2){
        index2= true;
        index1 = false;
        index3 = false;
      } else if (index ==3){
        index2= false;
        index1 = false;
        index3 = true;
      }
    });

  }
}