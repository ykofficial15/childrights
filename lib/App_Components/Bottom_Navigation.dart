import 'package:childrights/App_Components/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'Home.dart';

class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _buildPageContent(),
      ),
      bottomNavigationBar: CurvedNavigationBar(
buttonBackgroundColor: Colors.purple,
        backgroundColor: Colors.white,
        color: Colors.purple,
        height: 50,
        items: <Widget>[
          Icon(
            color: Colors.white,
            Icons.home,
            size: 30,
          ),
          Icon(
            color:Colors.white,
            Icons.person,
            size: 30,
          ),
        ],
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildPageContent() {
    if (_selectedIndex == 0) {
      return Center(
        child: Home(),
      );
    } else {
      return Center(
        child: UserScreen(),
      );
    }
  }
}
