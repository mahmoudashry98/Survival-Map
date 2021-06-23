import 'package:chatify/models/contect.dart';
import 'package:chatify/pages/home_page.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

class MyApp extends StatelessWidget {
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
          },
          home: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ChatPage();
                } else {
                  return LoginPage();
                }
              }),
        ));
  }
}
