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
                    Container(
                        child: Text("PERSONAL DETAILS",style: TextStyle(fontWeight:FontWeight.bold,),)),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text("Name",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("qwerty"),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text("Gender",style: TextStyle(fontWeight: FontWeight.bold),),
                            Text("Male"),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                              Text("College",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("qwerty University"),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: <Widget>[
                              Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(width:150,child: Text("qwerty@University.asdf",maxLines: 5,overflow: TextOverflow.ellipsis,)),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                        ),
                      ),
                    ),
                    Container(
                        child: Text("OTHER INFORMATION",style: TextStyle(fontWeight:FontWeight.bold,),)),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: <Widget>[
                              Text("Areas of intrest",style: TextStyle(fontWeight: FontWeight.bold),),
                              Container(
                                width: 150,
                                child: Text("qwerty wertyjklghsadsfvcdxsdsvcx University",textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis, maxLines: 5),
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            children: <Widget>[
                              Text("Location",style: TextStyle(fontWeight: FontWeight.bold),),
                              Text("Haryan,NCR"),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        onPressed: () {
                          //Navigator.of(context).pushNamed(HomePage.tag);
                        },
                        padding: EdgeInsets.all(12),
                        color: Colors.blueAccent,
                        child: Text('Update Profile', style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ],
                ),
              )
            ),
          ),
      );
  }

}