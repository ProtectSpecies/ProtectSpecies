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

  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF9CCC65), Color(0xFF7CB342), Color(0xFF558B2F), Color(0xFF33691E)],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                padding: EdgeInsets.fromLTRB(40.0,00.0,40.0,0.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'WELCOME TO PROTECT SPECIES',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.green[900],
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.green[900],
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xFF33691E),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                 ),
                              ],
                          ),
                          height: 60.0,
                          child: TextField(
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(color: Colors.white,),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(top: 14.0),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: Colors.white,
                              ),
                              hintText: 'Enter your Email',
                              hintStyle: TextStyle(color: Colors.white54,),
                            ),
                          ),
                        ),
                      ],
                    ),

                      SizedBox(height: 20.0),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xFF33691E),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 6.0,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            height: 60.0,
                            child: TextField(
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter your Password',
                                hintStyle:  TextStyle(color: Colors.white54),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green[900]),
                            elevation: MaterialStateProperty.all<double>(20.0),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                              dynamic result = await _auth.signInWithEmail(email, password);
                              if (result==null) {
                                setState(() {
                                  error = "Problem with signing in!";
                                });
                              }
                            }
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green[900]),
                            elevation: MaterialStateProperty.all<double>(20.0),
                          ),
                          child: Text(
                            'Sign In Anonymously',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            _auth.signInAnon();
                          }
                      ),
                      SizedBox(height: 30),
                      GestureDetector(
                          onTap: () {
                            return widget.changeView();
                        },
                        child: RichText(
                          text: TextSpan(
                              children: [
                              TextSpan(
                                  text: 'Don\'t have an Account? ',
                                      style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w400,
                                      ),
                                  ),
                              TextSpan(
                                text: 'Sign Up',
                                style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
          ),
        ),
    );
  }
}
