import 'package:flutter/material.dart';

class Identify extends StatefulWidget {

  final Function toggleView;
  Identify({this.toggleView});

  @override
  _IdentifyState createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: Text("Identify Page"),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.all(120),
          child:TextButton.icon(onPressed: () {return widget.toggleView();} , icon: Icon(Icons.home), label: Text("Home Screen")),
        ),
      ),
    );
  }
}