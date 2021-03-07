import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';


class Register extends StatefulWidget {

  final Function changeView;
  Register({this.changeView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

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
            title: Text("Sign up to Animal Identifier"),
            actions: <Widget>[
              TextButton.icon(
                icon: Icon(Icons.arrow_forward_ios_rounded),
                onPressed: () {
                  return widget.changeView();
                },
                label: Text("Sign in"),
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
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          dynamic result = await _auth.registerWithEmail(email, password);
                          if (result==null) {
                            setState(() {
                              error = "please enter a valid email";
                            });
                          }
                        }
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
