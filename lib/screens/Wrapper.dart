import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authenticate/authenticate.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:flutterapp/screens/home/organizatinal_page.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/models/fUser.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() {
    return new _WrapperState();
  }
}

class _WrapperState extends State<Wrapper>{
  final FirebaseAuth auth = FirebaseAuth.instance;

  String _role;

  var user;

  _WrapperState() {
    user = auth.currentUser;
    getRole(user).then((val) => setState(() {
      _role = val;
    }));
  }

  @override
  Widget build(BuildContext context) {

    // return either home page or authentication page
    if (user == null){
      return Authenticate();
    }

    else if (_role == 'org') {
      return MainPages();
    }

    else {
      return MainPages();
    }

  }

  Future<String> getRole (var user) async {
    DocumentReference currUser = FirebaseFirestore.instance.collection('accounts').doc(user.uid);
    return (await currUser.get())['role'];
  }

}
