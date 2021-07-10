import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
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
        bottomNavigationBar: FFNavigationBar(
            theme: FFNavigationBarTheme(
              barBackgroundColor: Colors.white,
              selectedItemBorderColor: Color.fromRGBO(232, 241, 249, 1.0),
              selectedItemBackgroundColor: Colors.blue,
              selectedItemIconColor: Colors.white,
              selectedItemLabelColor: Colors.black,
             // unselectedItemIconColor: Colors.black,
             // unselectedItemLabelColor:Colors.black,
            ),
            selectedIndex: _selectedIndex,
            onSelectTab: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: [
              FFNavigationBarItem(
                iconData: Icons.location_on,
                label: 'Map',
              ),
              FFNavigationBarItem(
                iconData: Icons.chat_outlined,
                label: 'Chat',
              ),

              FFNavigationBarItem(
                iconData: Icons.settings,
                label: 'Settings',
              ),
            ]));
  }
}
