import 'package:flutter/material.dart';
import 'package:flutterapp/services/auth.dart';


class Register extends StatefulWidget {

  final Function changeView;
  Register({this.changeView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthanticateServ _auth = AuthanticateServ();

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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFBDE2C8),
                    Color(0xFF93C8AC),
                    Color(0xFF65AB8C),
                    Color(0xFF54997A)],
                  stops: [0.1, 0.3, 0.7, 0.9],
                ),
              ),
              height: double.infinity,
              width: double.infinity,
            ),
            SingleChildScrollView(
              child: Container(
                height: 850,
                padding: EdgeInsets.fromLTRB(40.0,00.0,40.0,0.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 15),
                      Image.asset(
                        "images/logo_transparent.png",
                        width: 350,
                        height: 350,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Create an Account',
                            style: TextStyle(
                              color: Color(0xFF103A3E),
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xFF103A3E),
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
                                prefixIcon: Icon(Icons.email_rounded, color: Colors.white,),
                                hintText: 'Email',
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
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: Color(0xFF103A3E),
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
                                prefixIcon: Icon(Icons.lock_outlined, color: Colors.white,),
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white54,),
                              ),
                              style: TextStyle(color: Colors.white,),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF103A3E)),
                            elevation: MaterialStateProperty.all<double>(20.0),
                          ),
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            dynamic result = await _auth.registerWithEmail(
                                email, password, 'user');
                            if (result == null) {
                              setState(() {
                                error = "please enter a valid email";
                              });
                            }
                          }
                      ),
                      SizedBox(height: 5.0),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF103A3E)),
                            elevation: MaterialStateProperty.all<double>(20.0),
                          ),
                          child: Text(
                            'Organization',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            dynamic result = await _auth.registerWithEmail(
                                email, password, 'org');
                            if (result == null) {
                              setState(() {
                                error = "please enter a valid email";
                              });
                            }
                          }
                      ),
                      SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 30,),
                      GestureDetector(
                        onTap: () {
                          return widget.changeView();
                        },
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: 'Sign In',
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
            ),
            ],
        ),
      ),
    );
  }
}