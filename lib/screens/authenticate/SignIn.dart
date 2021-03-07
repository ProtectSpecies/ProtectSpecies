import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';

class SignIn extends StatefulWidget {

  final Function changeView;
  SignIn({this.changeView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthanticateServ _auth =  AuthanticateServ();
  final _formKey = GlobalKey<FormState>();

  String error = "";
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.redAccent,
            elevation: 0.0,
            title: Text("Sign in to Animal Identifier"),
              actions: <Widget>[
                TextButton.icon(
                  icon: Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    return widget.changeView();
                  },
                  label: Text("Register"),
                ),
              ]
          ),
          body: Container(
              padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                  child: Column(
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    TextFormField(
                      validator: (val) => val.isEmpty ? "Enter an email" : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                    SizedBox(height: 15.0),
                    TextFormField(
                      obscureText: true,
                      validator: (val) => val.length<6 ? "Your password should contain at least 6 characters !" : null,
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
                      if (_formKey.currentState.validate()) {
                        print("valid");
                        dynamic result = await _auth.signInWithEmail(email, password);
                        if (result==null) {
                          setState(() {
                            error = "Problem with signing in!";
                          });
                        }
                      }
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
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14.0,
                      ),
                    )
                    ],
                ),
            )
        ),
      ),
    );
  }
}
