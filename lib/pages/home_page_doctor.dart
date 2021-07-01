// import 'package:chatify/models/contact_doctor.dart';
// import 'package:flutter/material.dart';
// import 'package:chatify/pages/map_page.dart';
// import 'package:chatify/models/contact_user.dart';
// import 'package:chatify/pages/setting_user_page.dart';
// import 'dart:async';
// import 'package:flutter/services.dart';
// import 'package:location/location.dart';
// class HomePageDoctor extends StatefulWidget {
//
//   @override
//   _NavState createState() => _NavState();
// }
//
// class _NavState extends State<HomePageDoctor> {
//   int _selectedIndex = 0;
//   List<Widget> _widgetOptions = <Widget>[
//     GMap(),
//     ChatPageDoctor(),
//     SettingUserPage(),
//   ];
//
//   void _onItemTap(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     checkLocationServicesInDevice();
//   }
//
//
//   Future<void> checkLocationServicesInDevice() async {
//     Location location = new Location();
//
//     var _serviceEnabled = await location.serviceEnabled();
//
//     if (_serviceEnabled) {
//       var  _permissionGranted = await location.hasPermission();
//
//       if (_permissionGranted == PermissionStatus.granted) {
//         // _location = await location.getLocation();
//
//         // print(_location.latitude.toString() + " " + _location.longitude.toString());
//
//
//       } else {
//         _permissionGranted = await location.requestPermission();
//
//         if (_permissionGranted == PermissionStatus.granted) {
//           print('user allowed');
//         } else {
//           SystemNavigator.pop();
//         }
//       }
//     } else {
//       var _serviceEnabled = await location.requestService();
//
//       if (_serviceEnabled) {
//         var _permissionGranted = await location.hasPermission();
//
//         if (_permissionGranted == PermissionStatus.granted) {
//           print('user allowed before');
//         } else {
//           _permissionGranted = await location.requestPermission();
//
//           if (_permissionGranted == PermissionStatus.granted) {
//             print('user allowed');
//           } else {
//             SystemNavigator.pop();
//           }
//         }
//       } else {
//         SystemNavigator.pop();
//       }
//
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.location_on,
//             ),
//             title: Text(
//               'Map',
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.chat_bubble,
//             ),
//             title: Text(
//               'Chat',
//             ),
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.settings,
//             ),
//             title: Text(
//               'Settings',
//             ),
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         onTap: _onItemTap,
//         selectedFontSize: 13.0,
//         unselectedFontSize: 13.0,
//       ),
//
//     );
//   }
// }
