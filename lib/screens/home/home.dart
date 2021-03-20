import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF9CCC65),
                  Color(0xFF7CB342),
                  Color(0xFF558B2F),
                  Color(0xFF33691E)
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
              ),
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          Center(
            child: Container(
              child: Text(
                "Home Page",
                textScaleFactor: 2.0,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
