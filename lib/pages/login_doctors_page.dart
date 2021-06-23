import 'package:chatify/providers/auth_provider.dart';
import 'package:flutter/material.dart';


class LoginDoctor extends StatefulWidget {

  @override
  _LoginDoctorState createState() => _LoginDoctorState();
}

class _LoginDoctorState extends State<LoginDoctor> {
  double _deviceHeight;
  double _deviceWidht;

  GlobalKey<FormState> _formkey;
  AuthProvider _auth;
  String _email;
  String _password;

  _LoginDoctorState(){
    _formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidht = MediaQuery.of(context).size.width;


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}
