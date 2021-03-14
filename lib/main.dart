import 'package:flutter/material.dart';
import 'package:flutterapp/screens/Wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/models/fUser.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      /// Initialize FlutterFire

      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("Something went wrong");
        }

        /// Once complete, show your application

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<FbUser>.value(
            value: AuthanticateServ().user,
            initialData: null,
            child: Wrapper(),
          );
        }

        /// Waiting for initialization to complete

        return Container(width: 0.0, height: 0.0);
      },
    );
  }
}
