import 'package:flutter/material.dart';
import 'package:chatify/pages/map_page.dart';
import 'package:chatify/models/contact.dart';
import 'package:chatify/pages/setting.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
class HomePage extends StatefulWidget {

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    GMap(),
    ChatPage(),
    SettingPage(),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.location_on,
            ),
            title: Text(
              'Map',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.chat_bubble,
            ),
            title: Text(
              'Chat',
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
            ),
            title: Text(
              'Settings',
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedFontSize: 13.0,
        unselectedFontSize: 13.0,
      ),

    );
  }
}
