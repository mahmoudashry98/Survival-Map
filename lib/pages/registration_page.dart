import 'package:flutter/material.dart';
import 'dart:io';
import '../services/snackbar_service.dart';
import '../services/navigation_service.dart';
import '../services/cloud_storage_service.dart';
import '../services/db_service.dart';
import '../services/media_service.dart';
import '../providers/auth_provider.dart';
import 'package:provider/provider.dart';
import '../services/db_service.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool passwordVisible = true;
  double _deviceHeight;
  double _deviceWidth;

  GlobalKey<FormState> _formkey;
  AuthProvider _auth;
  String _name;
  String _age;
  String _address;
  String _phone;
  String _email;
  String _password;
  File _image;
  bool _isUser = false;

  TextEditingController password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();

  _RegistrationPageState() {
    _formkey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("lib/ima/SE4.jpeg"),
                  fit: BoxFit.cover,
                )),
                child: Align(
                  alignment: Alignment.center,
                  child: ChangeNotifierProvider<AuthProvider>.value(
                    value: AuthProvider.instance,
                    child: registrationPageUI(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget registrationPageUI() {
    return Builder(
      builder: (BuildContext _context) {
        SnackBarService.instance.buildContext = _context;
        _auth = Provider.of<AuthProvider>(_context);
        return Container(
          height: _deviceHeight * 1.0,
          width: _deviceWidth * 2.0,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox( height:0),
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
      height: _deviceHeight * 0.09,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[

          Text(
            "      Welcome,",
            style: TextStyle(
                fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            "Let’s Create An Account!",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      height: _deviceHeight * 0.80,
      width: _deviceWidth * 1.9,
      child: Form(
        key: _formkey,
        onChanged: () {
          _formkey.currentState.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                child: Text(
              "Register..",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            )),
            _imageSelectorWidget(),
            Card(
                color: Color.fromRGBO(232, 241, 249, 1.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Column(children: [
                  SizedBox(
                    height: 20,
                  ),
                  _nameTextField(),
                  _emailTextField(),
                  _passwordTextField(),
                  _confirmPasswordTextField(),
                  SizedBox(
                    height: 15,
                  ),
                  _registrationButton()
                ]))
            // _backToLoginPageButton()
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () async {
          File _imageFile = await MediaService.instance.getImageFromLibrary();
          setState(() {
            _image = _imageFile;
          });
        },
        child: Container(
          height: _deviceHeight * 0.10,
          width: _deviceHeight * 0.10,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: _image != null
                  ? FileImage(_image)
                  : NetworkImage(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWo3luud5KPZknLR5zdUUwzvYBztWgTxrkbA&usqp=CAU"),
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      color: Colors.white,
      child: TextFormField(
        autocorrect: false,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        validator: (_input) {
          return _input.length != 0 ? null : "Please enter a name";
        },
        onSaved: (_input) {
          setState(() {
            _name = _input;
          });
        },
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "Full Name...",
          hintStyle: TextStyle(fontSize: 20, color: Colors.black38),
          prefixIcon: Icon(
            Icons.person_rounded,
            color: Colors.black,
          ),
        ),
      ),
      //),
    );
  }

  Widget _emailTextField() {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.only(top: 10, left: 10, right: 10),
        color: Colors.white,
        child: TextFormField(
          autocorrect: false,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          validator: (_input) {
            return _input.length != 0 && _input.contains("@")
                ? null
                : "Please enter a valid email";
          },
          onSaved: (_input) {
            setState(() {
              _email = _input;
            });
          },
          cursorColor: Colors.white,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Email...",
            hintStyle: TextStyle(fontSize: 20, color: Colors.black38),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return Center(
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          color: Colors.white,
          child: TextFormField(
            controller: password,
            autocorrect: false,
            obscureText: passwordVisible,
            style: TextStyle(color: Colors.black),
            validator: (_input) {
              if (_input.isEmpty) {
                return 'Please enter Password';
              } else if (_input.length < 6) {
                return 'Password must be at least 6 characters long.';
              }
              return null;
              // return _input.length != 6 ? null : "Please enter a password";
            },
            onSaved: (_input) {
              setState(() {
                _password = _input;
              });
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Password...",
              hintStyle: TextStyle(fontSize: 20, color: Colors.black38),
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

  Widget _confirmPasswordTextField() {
    return Column(children: <Widget>[
      Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          color: Colors.white,
          child: TextFormField(
            controller: _confirmPassword,
            autocorrect: false,
            obscureText: passwordVisible,
            style: TextStyle(color: Colors.black),
            validator: (_input) {
              if (_input.isEmpty) {
                return 'Password cannot be empty';
              } else if (password.text != _confirmPassword.text) {
                return 'Password do not match!';
              }
              return null;
              // return _input.length != 6 ? null : "Please enter a password";
            },
            onSaved: (_input) {
              setState(() {
                _password = _input;
              });
            },
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: "Confirm Password...",
              hintStyle: TextStyle(fontSize: 20, color: Colors.black38),
              suffixIcon: IconButton(
                icon: Icon(
                    passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
          )),
      // Checkbox(
      //     value: _isUser,
      //     onChanged: (bool value) {
      //       print(value);
      //       setState(() {
      //         _isUser = value;
      //       });
      //     })
    ]);
  }

  Widget _registrationButton() {
    return _auth.status != AuthStatus.Authenticating
        ? Container(
            margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 70),
            height: _deviceHeight * 0.06,
            width: _deviceWidth,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                if (_formkey.currentState.validate() && _image != null) {
                  _auth.registerUserWithEmailAndPassword(_email, _password,
                      (String _uid) async {
                    var _result = await CloudStorageService.instance
                        .uploadUserImage(_uid, _image);
                    var _imageURL = await _result.ref.getDownloadURL();
                    await DBService.instance.createUserInDB(_uid, _name, _email,
                        _imageURL, _isUser, _age, _address, _phone);
                  });
                }
              },
              color: Colors.white,
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.blue),
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }
}
