import 'package:flutter/material.dart';
import 'package:sweetgiftbox/screen/feed.dart';
import 'package:sweetgiftbox/screen/orders.dart';
import 'package:sweetgiftbox/screen/profile.dart';
import 'package:sweetgiftbox/view/homepage.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final String title;

  final List<Widget> body = [
    HomePage(title: '',),
    Feed(),
    Orders(),
    Profile()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: body[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              activeIcon: new Icon(Icons.home, color: Colors.red),
              icon: new Icon(Icons.home, color: Colors.grey),
              title: new Text('Home',
                  style: TextStyle(
                      color: _currentIndex == 0 ? Colors.red : Colors.grey)),
            ),
            BottomNavigationBarItem(
              activeIcon:
                  new Icon(Icons.filter_none_rounded, color: Colors.red),
              icon: new Icon(Icons.filter_none_rounded, color: Colors.grey),
              title: new Text('Feed',
                  style: TextStyle(
                      color: _currentIndex == 1 ? Colors.red : Colors.grey)),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(Icons.view_list_outlined, color: Colors.red),
              icon: new Icon(Icons.view_list_outlined, color: Colors.grey),
              title: new Text('Orders',
                  style: TextStyle(
                      color: _currentIndex == 2 ? Colors.red : Colors.grey)),
            ),
            BottomNavigationBarItem(
              activeIcon: new Icon(Icons.person, color: Colors.red),
              icon: new Icon(Icons.person, color: Colors.grey),
              title: new Text('Me',
                  style: TextStyle(
                      color: _currentIndex == 3 ? Colors.red : Colors.grey)),
            ),
          ]),
    );
  }
}
