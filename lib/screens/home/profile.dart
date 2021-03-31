import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/screens/home/updateProfile.dart';

class CustomContainerShaper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path newPath = new Path();

    newPath.lineTo(0, size.height);

    newPath.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    newPath.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 20);

    newPath.lineTo(size.width, 0);

    return newPath;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class GetPhotosTaken extends StatelessWidget {
  final String documentId;

  GetPhotosTaken(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('accounts');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(this.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

        if (snapshot.hasError) {
          return Text("Something went wrong",
            style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 15.0,
            ),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return Text("${data['photosTaken']}",
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.0,
              fontSize: 15.0,
            ),
          );
        }

        return Text("loading",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.0,
            fontSize: 15.0,
          ),
        );
      },
    );
  }
}

class _ProfileState extends State<Profile> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  String getName(String userName) {
    return userName != null
        ? (FirebaseAuth.instance.currentUser.displayName)
        : "";
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _drawerKey,
        endDrawer: settingsDrawer(),
        body: Stack(children: [
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
          ClipPath(
            clipper: CustomContainerShaper(),
            child: Container(
              height: 175,
              color: Color(0xFF103A3E),
              child: Column(children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      Text("Protect Species",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          )),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed: () {
                          _drawerKey.currentState.openEndDrawer();
                        },
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30.0, 140.0, 30.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 150.0,
                  child: Icon(
                    Icons.person,
                    size: 100.0,
                  ),
                ),
                Text(
                  "Name",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  getName(FirebaseAuth.instance.currentUser.displayName),
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 2.0,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.email,
                    ),
                    SizedBox(width: 10.0),
                    Text(FirebaseAuth.instance.currentUser.email,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                        )),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.camera,
                    ),
                    SizedBox(width: 10.0),
                    GetPhotosTaken(FirebaseAuth.instance.currentUser.uid),
                  ],
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  child: Text(
                    "Update Profile",
                  ),
                  style: ButtonStyle(
                    //padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(20, 20, 25,0)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black12),
                  ),
                  onPressed: () async {
                    return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()),
                    );
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
