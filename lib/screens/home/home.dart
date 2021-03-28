import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/screens/home/identify.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';



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

  int _currentIndex=0;

  List cardList=[

    Image.asset(
      "images/endangered_species_group.jpg",
      width: 350,
      height: 200,
      fit: BoxFit.cover,
    ),

    Container(
      padding: const EdgeInsets.all(20),
      child: Text(
          'aa',
          softWrap: true,
          style: TextStyle(
            //fontFamily: 'RobotoMono',
              fontSize: 18
          )
      ),
    ),
    Image.asset(
      "images/endangered_species_group.jpg",
      width: 400,
      height: 250,
      fit: BoxFit.cover,
    ),

    Container(
      padding: const EdgeInsets.all(20),
      child: Text(
          'aa',
          softWrap: true,
          style: TextStyle(
            //fontFamily: 'RobotoMono',
              fontSize: 18
          )
      ),
    ),
  ];





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
                                    fontFamily: 'RobotoMono-Bold',
                                  ),

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
              SizedBox(height: 80),

              CarouselSlider(
                options: CarouselOptions(
                  height: 250.0,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  //autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                items: cardList.map((card){
                  return Builder(
                      builder:(BuildContext context){
                        return  Container(
                          height: MediaQuery.of(context).size.height*0.30,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            color: Color(0xFF103A3E),
                            child: card,
                          ),
                        );
                      }
                  );
                }).toList(),
              ),

              SizedBox(height: 50),

              /*

              ProgressButton(
                defaultWidget: Row(
                  children: [

                    SizedBox(width: 35),

                    Text(
                        'Scan Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        )
                    ),

                    SizedBox(width: 20),

                    Icon(
                        Icons.camera,
                        color: Colors.white
                    ),
                  ],
                ),
                color: Color(0xFF103A3E),
                progressWidget: const CircularProgressIndicator(),
                width: 196,
                height: 45,
                borderRadius: 45/2,
                onPressed: () async {
                  int score = await Future.delayed(
                      const Duration(milliseconds: 1500), () => 42);
                  return Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Page1Camera()),
                  );
                },
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