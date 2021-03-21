import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/screens/home/identify.dart';

import 'package:flutterapp/screens/home/profile.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:tflite/tflite.dart';

int selectedIndex2 = 1;

class MainPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void pageChanged(int index) {
    setState(() {
      selectedIndex = index;
      selectedIndex2 = index;

      print(selectedIndex.toString() + 'up');
    });
  }

  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );
  int selectedIndex = 1;

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Page1Camera(),
        Home(),
        Profile(),
      ],
    );
  }

  void bottomTapped(int index) {
    setState(() {
      selectedIndex = index;
      selectedIndex2 = index;
      pageController.jumpToPage(index);

      print(selectedIndex.toString() + 'bottom');
      // pageController.animateToPage(index,
      //     duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  bool isloading = false;

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  void initState() {
    super.initState();
    isloading = true;
    loadModel().then((value) {
      setState(() {
        isloading = false;
      });
    });
  }

  final AuthanticateServ _auth = AuthanticateServ();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  List<Widget> _widgetOptions = <Widget>[
    Page1Camera(),
    Home(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        appBar: (selectedIndex != 0)
            ? AppBar(
                //TODO Change title style
                backgroundColor: Colors.green[900],
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.all(20.0),
                ),
                title: Text('AnimalApp',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    )),
                actions: <Widget>[
                    IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () => _drawerKey.currentState.openEndDrawer(),
                    ),
                  ])
            : null,
        body: buildPageView(),
        bottomNavigationBar: (selectedIndex != 0)
            ? Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.green[900],
                ),
                child: BottomNavigationBar(
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.white,
                  currentIndex: selectedIndex,
                  onTap: (index) {
                    bottomTapped(index);
                  },
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.camera_alt_outlined),
                      label: 'Identify',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle),
                      label: 'Profile',
                    ),
                  ],
                ),
              )
            : null,
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Text(
                  'Settings',
                  textScaleFactor: 2.0,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                  color: Colors.green[900],
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {},
              ),
              ListTile(title: Text('Item 3'), onTap: () {}),
              SizedBox(height: 370.0),
              TextButton.icon(
                icon: Icon(Icons.person),
                onPressed: () async {
                  await _auth.signOut();
                },
                label: Text("Log Out"),
              ),
            ],
          ),
        ));
  }
}
