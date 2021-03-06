import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthanticateServ _auth =  AuthanticateServ();

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.greenAccent[100],
          appBar: AppBar(
            backgroundColor: Colors.brown[400],
            elevation: 0.0,
            title: Text("Sign in to Animal Identifier"),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    return widget.toggleView();
                  },
                  label: Text("Register"),
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
                        'Sign In',
                        style: TextStyle(color: Colors.white),
                      ),
                    onPressed: () async {
                      print(email);
                      print(password);
                        }
                      ),
                    ElevatedButton(
                        child: Text(
                          'Sign In Anonymously',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          _auth.signInAnon();
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
