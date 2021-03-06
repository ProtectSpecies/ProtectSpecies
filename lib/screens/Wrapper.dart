import 'package:flutter/material.dart';
import 'package:flutterapp/screens/authenticate/authenticate.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/models/fUser.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return either home page or authentication page

    final user = Provider.of<FbUser>(context);

    if (user == null){
      return Authenticate();
    } else {
      //return WrapperHomeScreen();
      return MainPages();
    }

  }
}
