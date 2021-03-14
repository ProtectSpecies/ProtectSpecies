import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
        "This is settings page",
        textScaleFactor: 2.0,
        style: TextStyle(fontWeight: FontWeight.bold),
        ),
      )
    );
  }
}
