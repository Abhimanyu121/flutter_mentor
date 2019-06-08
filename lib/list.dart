import 'package:flutter/material.dart';
class List_tab extends StatefulWidget {
  _list_ui createState() => new _list_ui();

}
class _list_ui extends State<List_tab>{

  @override
  Widget build(BuildContext context) {
    print("called");
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.0),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),),
        child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              scrollDirection: Axis.vertical,
             children: <Widget>[
               Card(
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text("Abhimanyu Shekhawat",style: TextStyle(fontWeight:FontWeight.bold,),textAlign: TextAlign.left,),
                     ),
                     Padding(
                       padding: EdgeInsets.all(10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: <Widget>[
                           Text("Experience:",style: TextStyle(fontWeight:FontWeight.bold,),),
                           Text("12 Years"),
                         ],
                       ),
                     ),
                     Padding(
                       padding: EdgeInsets.all(10) ,
                       child: Column(
                         children: <Widget>[
                           Text("PROFICIENCY"),
                           Padding(
                             padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
                             child: Column(
                               children: <Widget>[
                                  Text("Flutter"),
                                  Text("Solidity")
                               ],
                             ),
                           ),
                         ],
                       ),
                      ),
                   ],
                 )
               ),
             ],

            )
        ),
      )

    );
  }

}