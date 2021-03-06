import 'package:flutter/material.dart';

class Identify extends StatefulWidget {
  @override
  _IdentifyState createState() => _IdentifyState();
}

class _IdentifyState extends State<Identify> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {},
          backgroundColor: Colors.lightBlue,
            child: Icon(Icons.camera_alt_outlined)
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: Text(
                "Identify",
                textScaleFactor: 2.0,
                style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}