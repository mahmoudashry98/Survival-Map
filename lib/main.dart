import 'package:chatify/pages/home_page.dart';
import 'package:chatify/pages/my_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'blocs/application_bloc.dart';
import 'pages/login_page.dart';
import './pages/registration_page.dart';
import './services/navigation_service.dart';
import './pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        // _location = await location.getLocation();

        // print(_location.latitude.toString() + " " + _location.longitude.toString());

      } else {
        _permissionGranted = await location.requestPermission();

        if (_permissionGranted == PermissionStatus.granted) {
          print('user allowed');
        } else {
          SystemNavigator.pop();
        }
      }
    } else {
      var _serviceEnabled = await location.requestService();

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
    return ChangeNotifierProvider(
        create: (context) => ApplicationBloc(),
        child: MaterialApp(
          title: 'Chatify',
          navigatorKey: NavigationService.instance.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: Color.fromRGBO(42, 117, 188, 1.0),
              accentColor: Colors.white,
              backgroundColor: Colors.white),
          initialRoute: "login",
          routes: {
            "login": (BuildContext _context) => LoginPage(),
            "register": (BuildContext _context) => RegistrationPage(),
            "home": (BuildContext _context) => HomePage(),
            "MyAccount": (BuildContext _context) => MyAccount(),

          },
        ));
  }
}
