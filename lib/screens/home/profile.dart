import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';



class CustomContainerShaper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path newPath = new Path();

    newPath.lineTo(0, size.height) ;

    newPath.quadraticBezierTo(size.width/4, size.height-40, size.width/2, size.height-20) ;
    newPath.quadraticBezierTo(3/4 * size.width, size.height, size.width, size.height - 20) ;

    newPath.lineTo(size.width, 0) ;

    return newPath ;
  }

  @override

  bool shouldReclip(CustomClipper oldClipper) => true;

}



class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _drawerKey,
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
          ClipPath(
            clipper: CustomContainerShaper(),
            child: Container(
              height: 175,
              color: Color(0xFF103A3E),
              child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,10,10),
                      child: Row(
                        children: <Widget>[
                          Text(
                              "Protect Species",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 35.0,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () => _drawerKey.currentState.openEndDrawer(),
                          ),
                        ],
                      ),
                    )
                  ]
              ),
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
                    color: Colors.black,
                    letterSpacing: 2.0,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Nature Lover",
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
                    Text("nature_lover@protectspecies.com",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          letterSpacing: 1.0,
                        )),
                  ],
                ),
              ],
            ),
          ),
        ]),
        endDrawer: settingsDrawer(),
      ),
    );
  }
}
