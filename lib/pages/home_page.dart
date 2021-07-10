import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:chatify/pages/map_page.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/pages/setting_user_page.dart';

class HomePage extends StatefulWidget {
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    GMap(),
    ChatPageUser(),
    SettingUserPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white12,
        buttonBackgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.location_on_outlined, size: 30),
          Icon(Icons.chat_outlined, size: 30),
          Icon(Icons.settings, size: 30),
        ],
        onTap: _onItemTap,
      ),
    );
  }
}
