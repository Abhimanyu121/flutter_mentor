import 'package:flutter/material.dart';

class Profile extends StatefulWidget{
  _profile_ui createState() => new _profile_ui();
}
class _profile_ui extends State<Profile>{

  @override
  Widget build(BuildContext context) {
    print("called");
    // TODO: implement build
    return new Padding(
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
                child: ListView(
                  children: <Widget>[
                    Card(
                      child: Row(

                        children: <Widget>[
                          Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("qwerty"),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    Card(
                      child: Row(
                        children: <Widget>[
                            Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("qwerty"),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween
                      ),
                    ),
                  ],
                ),
              )
            ),
          ),
      );
  }

}