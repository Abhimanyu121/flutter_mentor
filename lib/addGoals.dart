import 'package:flutter/material.dart';
bool new_topic = false;
class addGoals extends StatefulWidget{
  _add_goals createState() => new _add_goals();
}
class _add_goals extends State<addGoals>{
  int initial =1;
  int max =1;
  @override
  Widget build(BuildContext context) {
    return new ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Learn Something Cool", style: TextStyle(fontWeight: FontWeight.bold),),
                DropdownButton<String>(
                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: null,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                     //Navigator.of(context).pushNamed(HomePage.tag);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Teach Something Cool", style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  (new_topic ?
                  TextFormField(
                  keyboardType: TextInputType.text,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: 'Name of New Subject',
                    contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                  ):DropdownButton<String>(
                    items: <String>['A', 'B', 'C', 'D'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: null,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                  ),
                  Row(
                    children: <Widget>[
                      Text("Something new?"),
                      Checkbox(
                        value: (new_topic? true:false),
                        onChanged:_check_change(),
                      ),
                    ],
                  ),
                  /*Column(
                    children: iterator(),
                  ),*/
                  RaisedButton(
                    child: Text("Add more"),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    onPressed: () {
                      setState(() {
                        max++;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
  _check_change()=> setState(() {
      print(new_topic.toString());
      if (new_topic==true){
        new_topic=false;
      }else{
        new_topic=true;
      }
    });
  dynamic iterator()=> setState(() {
      int i = initial;
      List<Widget> arr = new List<Widget>();
      for(i ; i<=max ; i++){
        dynamic wid =  adder();
        arr.add(wid);
      }
      return arr;
    });
  dynamic adder(){
    return new Row(
      children: <Widget>[
        Container(
          width: 50,
          child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Time",

              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
        ),
        Container(
          width: 50,
          child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Task",
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            ),
          ),
        )
      ],
    );
  }

}