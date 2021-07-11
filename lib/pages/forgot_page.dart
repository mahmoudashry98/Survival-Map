import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/loading.dart';
import 'package:chatify/services/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthProvider auth = AuthProvider();
  String _email, msg = "";
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 150, left: 20, right: 20),
                  child: Text(
                    "Rest Password ...",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 80, left: 20, right: 20),
                  child: Text(
                    "Enter your email address below to rest password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(208, 211, 212, 1), fontSize: 20),
                  ),
                ),
                Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: keys,
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (e) => _email = e,
                    validator: (e) => e.isEmpty ? "Please enter your email" : null,
                    decoration: InputDecoration(
                        hintText: "Enter your email", labelText: "Email"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if (keys.currentState.validate()) {
                        loading(context);
                        bool send = await auth.resetpassword(_email);
                        if (send) {
                          msg = "Check your mails";
                          Navigator.of(context).pop();
                          setState(() {});
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Send Email",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    msg,
                    style: TextStyle(color: Colors.blue),
                  ),


                ]),
              ),
            ),
      ]
          )
    ),
    );
  }






}
