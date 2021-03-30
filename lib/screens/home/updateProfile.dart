import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/profile.dart';

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  var user = FirebaseAuth.instance.currentUser;

  String newDisplayName = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFB8D9C6),
                      Color(0xFF93C8AC),
                      Color(0xFF65AB8C),
                      Color(0xFF54997A)
                    ],
                    stops: [0.1, 0.3, 0.7, 0.9],
                  ),
                ),
                height: double.infinity,
                width: double.infinity,
              ),
              SingleChildScrollView(
                child: Container(
                  height: 850,
                  padding: EdgeInsets.fromLTRB(40.0,0.0,40.0,0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 300),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'New Display Name',
                            style: TextStyle(
                              color: Color(0xFF103A3E),
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 30.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color:Color(0xFF103A3E),
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
                                setState(() => newDisplayName = val);
                              },
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(color: Colors.white,),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                hintText: 'Enter a new display name',
                                hintStyle: TextStyle(color: Colors.white54,),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.0),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF103A3E)),
                            elevation: MaterialStateProperty.all<double>(20.0),
                          ),
                          child: Text(
                            'Update Display Name',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            await FirebaseAuth.instance.currentUser.updateProfile(displayName:newDisplayName);
                            await FirebaseAuth.instance.currentUser.reload();
                            return
                              Navigator.pop(context, MaterialPageRoute(builder: (context) => UpdateProfile()));
                          }
                      ),
                    ],
                  ),
                ),
              ),
              ClipPath(
                clipper: CustomContainerShaper(),
                child: Container(
                  height: 175,
                  color: Color(0xFF103A3E),
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 10),
                      child: Row(
                        children: <Widget>[
                          ElevatedButton(
                            child: Icon(Icons.arrow_back),
                            style: ButtonStyle(
                              backgroundColor:
                              MaterialStateProperty.all<Color>(Color(0xFF103A3E)),
                            ),
                            onPressed: () async {
                              FirebaseAuth.instance.currentUser.reload();
                              return
                                Navigator.pop(context, MaterialPageRoute(builder: (context) => UpdateProfile()),);
                            },
                          ),
                          SizedBox(width: 40),
                          Text("Update Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
            ]
        ),
      ),
    );
  }
}
