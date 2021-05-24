import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/snackbar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  String email = "";
  double _deviceHeight;
  double _deviceWidht;

  GlobalKey<FormState> _formkey;
  AuthProvider _auth;

  _ForgotScreenState() {
    _formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidht = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
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
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: TextFormField(
                  validator: (_input) {
                    if (_input.isEmpty) {
                      return "Please enter your email";
                    } else {
                      email = _input;
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email Address...",
                    hintStyle: TextStyle(
                        fontSize: 20,
                        color: Color.fromRGBO(208, 211, 212, 1),
                        fontWeight: FontWeight.w500),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("lib/ima/SW4.jpeg"),
                fit: BoxFit.fill,
              )),
              child: Align(
                alignment: Alignment.center,
                child: ChangeNotifierProvider<AuthProvider>.value(
                  value: AuthProvider.instance,
                  child: _forgotPageUI(),
                ),
              ),
            )
          ]),
        ));
  }

  Widget _forgotPageUI() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        _auth = Provider.of<AuthProvider>(_context);
        return Container(
          height: _deviceHeight * 0.52,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidht * 0.12),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headingWidget(),
              _inputForm(),
            ],
          ),
        );
      },
    );
  }

   Widget _headingWidget() {
     return Container(
       height: _deviceHeight * 0.04,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisSize: MainAxisSize.max,
         children: <Widget>[
           Text(
             "",
             style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
           ),
         ],
       ),
     );
   }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.40,
      width: _deviceWidht * 0.80,
      child: Form(
        key: _formkey,
        onChanged: () {
          _formkey.currentState.save();
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: email).then((value) => print("Check your mails"));
                  }
                },
                color: Colors.white,
                child: Text(
                  "Send Email",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
