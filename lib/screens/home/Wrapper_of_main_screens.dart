import "package:flutter/material.dart";
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/screens/home/identify.dart';

class WrapperHomeScreen extends StatefulWidget {
  @override
  _WrapperHomeScreenState createState() => _WrapperHomeScreenState();
}

class _WrapperHomeScreenState extends State<WrapperHomeScreen> {

  bool showIdentify = true;
  void toggleView() {
    setState(() => showIdentify = !showIdentify);
  }

  @override
  Widget build(BuildContext context) {

      if (showIdentify){
        return Home(toggleView: toggleView);
      } else {
        return Identify(toggleView: toggleView);
      }
    }
  }


