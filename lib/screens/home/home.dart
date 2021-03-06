import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';



class Home extends StatefulWidget {

  final Function toggleView;
  Home({this.toggleView});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthanticateServ _auth =  AuthanticateServ();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Home Page"),
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text("Log Out"),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white70,
          elevation: 10.0,
          child: Container(
            child: OutlinedButton.icon(
                icon: Icon(Icons.camera_alt_outlined),
                label: Text("Identify"),
                onPressed: () {
                  return widget.toggleView();                  ///TODO Change this
                }
            ),
          ),
        ),
      ),
    );
  }
}



