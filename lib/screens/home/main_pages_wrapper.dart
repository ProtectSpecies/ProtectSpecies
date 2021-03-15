import 'package:flutter/material.dart';
import 'package:flutterapp/screens/home/home.dart';
import 'package:flutterapp/screens/home/identify.dart';
import 'package:flutterapp/screens/home/profile.dart';
import 'package:flutterapp/services/auth.dart';

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
  final AuthanticateServ _auth = AuthanticateServ();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    Page1Camera(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('AnimalApp'),
          actions: <Widget> [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _drawerKey.currentState.openEndDrawer(),
            ),
          ]
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_outlined),
            label: 'Identify',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
        endDrawer : Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Center(
                    child: Text(
                      'Settings',
                      textScaleFactor: 2.0,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                ),
                decoration: BoxDecoration(
                  color: Colors.red,
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
              ListTile(
                  title: Text('Item 3'),
                  onTap: () {}
              ),
              SizedBox(height:370.0),
              TextButton.icon(
                icon: Icon(Icons.person),
                onPressed: () async {
                  await _auth.signOut();
                },
                label: Text("Log Out"),
              ),
            ],
          ),
        )
    );
  }
}
