import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:flutterapp/screens/home/profile.dart';

class AboutUs extends StatelessWidget {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10,15,10,10),
                    child: Row(
                      children: <Widget>[

                        ElevatedButton(
                          child: Icon(Icons.arrow_back),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF103A3E)), ),
                          onPressed: () async {
                          int score = await Future.delayed(
                              const Duration(milliseconds: 1500), () => 42);
                          return Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => AboutUs()),
                          );
                        },
                        ),


                        SizedBox(width: 60),

                        Text(
                            "About Us",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 35.0,
                              fontWeight: FontWeight.bold,
                            )
                        ),


                      ],
                    ),
                  )
                ]
            ),
          ),
        ),
        ]
      ),
      endDrawer: settingsDrawer(),
    );
  }
}
