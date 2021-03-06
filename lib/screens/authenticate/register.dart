import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';


class Register extends StatefulWidget {

  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthanticateServ _auth =  AuthanticateServ();

  String email = '';
  String password = '';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.greenAccent[100],
        appBar: AppBar(
            backgroundColor: Colors.redAccent,
            elevation: 0.0,
            title: Text("Sign up to Animal Identifier"),
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () {
                  return widget.toggleView();
                },
                label: Text("Sign in"),
              ),
          ]
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
            child: Form(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15.0),
                  TextFormField(
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    obscureText: true,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        print(email);
                        print(password);
                      }
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
