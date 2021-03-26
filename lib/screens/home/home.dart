import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';


class CustomContainerShaper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path newPath = Path();

    newPath.lineTo(0.0, size.height);

    newPath.quadraticBezierTo(size.width * 0.25, size.height - 50.0,size.width * .5, size.height - 30.0);
    newPath.quadraticBezierTo(size.width * .75,size.height - 10, size.width, size.height - 55.0);

    newPath.lineTo(size.width, 0.0);

    newPath.close();

    return newPath;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;

}



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFBDE2C8),
                  Color(0xFF93C8AC),
                  Color(0xFF65AB8C),
                  Color(0xFF54997A),
                ],
                stops: [0.1, 0.3, 0.7, 0.9],
              ),
            ),
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            children: [
              ClipPath(
                clipper: CustomContainerShaper(),
                child: Container(
                  height: 230,
                  color: Color(0xFF103A3E),
                  child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 60.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20,10,10,40),
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
              SizedBox(height: 40),


              /*
              Container(
                padding: EdgeInsets.fromLTRB(150,80,150,40),
                decoration: BoxDecoration(
                    color: Color(0xFF24666B),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)
                    )
                ),

                child: Text(
                  "he",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.fromLTRB(150,80,150,40),
                decoration: BoxDecoration(
                    color: Color(0xFF24666B),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)
                    )
                ),

                child: Text("hello"),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.fromLTRB(150,80,150,40),
                decoration: BoxDecoration(
                    color: Color(0xFF24666B),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        bottomRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)
                    )
                ),

                child: Text("hello"),
              ),
              */

            ],
          ),
        ],
      ),
        endDrawer: settingsDrawer(),
    );
  }
}