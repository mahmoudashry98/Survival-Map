import 'package:chatify/pages/recent_conversations_page.dart';
import 'package:flutter/material.dart';
import 'package:chatify/pages/map_page.dart';
import 'package:chatify/models/contect.dart';
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
  void initState() {
    super.initState();
    checkLocationServicesInDevice();
  }

  Future<void> checkLocationServicesInDevice() async {
    Location location = new Location();

    var _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      var _permissionGranted = await location.hasPermission();

      if (_permissionGranted == PermissionStatus.granted) {
      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      _serviceEnabled = await location.requestService();

      if (_serviceEnabled) {
        var _permissionGranted = await location.hasPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed before');
        } else {
          _permissionGranted = await location.requestPermission();

          if (_permissionGranted == PermissionStatus.granted) {
            print('user allowed');
          } else {
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
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
