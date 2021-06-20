import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/screens/home/AboutUs.dart';
import 'package:flutterapp/screens/home/main_pages_wrapper.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CustomContainerShaper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path newPath = Path();

    newPath.lineTo(0.0, size.height);

    newPath.quadraticBezierTo(size.width * 0.25, size.height - 50.0,
        size.width * .5, size.height - 30.0);
    newPath.quadraticBezierTo(
        size.width * .75, size.height - 10, size.width, size.height - 55.0);

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

  int _currentIndex = 0;

  List cardList = [
    Column(
      children: [
        Image.asset(
          "images/arctic_fox",
          width: 260,
          height: 218,
        ),
        SizedBox(height: 3),
        Text(
          "Arctic Fox",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/tiger.jpg",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Tiger",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/snow_leopard",
          width: 600,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Snow Leopard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/panda",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Panda",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/orangutan",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Orangutan",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/Marco_Polo_Sheap",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Marco Polo Sheap",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/jaguar",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Jaguar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/hyena",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Hyena",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/chimpanzee",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Chimpanzee",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/cheetah",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Cheetah",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/amur_leopard",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "Amur Leopard",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
    Column(
      children: [
        Image.asset(
          "images/African_Elephant.jpg",
          width: 260,
          height: 210,
        ),
        SizedBox(height: 3),
        Text(
          "African Elephant",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono-Bold',
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      endDrawer: settingsDrawer(context),
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
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: 50.0,
                          ),
                          Spacer(),
                          Image.asset(
                            "images/logo.png",
                            width: 220,
                            height: 220,
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () =>
                                _drawerKey.currentState.openEndDrawer(),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ),
              SizedBox(height: 35),
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
                items: cardList.map((card) {
                  return Builder(builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.30,
                      width: MediaQuery.of(context).size.width,
                      child: Card(
                        color: Color(0xFF103A3E),
                        child: card,
                      ),
                    );
                  });
                }).toList(),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  //padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(20, 20, 25,0)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/endangered_species_group.jpg",
                      width: 230,
                      height: 175,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 30),
                    Text(
                      "  About\nOur App",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoMono-Bold',
                      ),
                    )
                  ],
                ),
                onPressed: () async {
                  return Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutUs()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
