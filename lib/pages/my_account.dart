import 'package:chatify/models/contact.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccount createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  bool showPassword = false;

  AuthProvider _auth;
  double _width;
  double _height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          textTheme: TextTheme(),
          title: Text(
            "Edit Profile",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            child: ChangeNotifierProvider<AuthProvider>.value(
              value: AuthProvider.instance,
              child: _profilePageUI(),
            ),
          ),
        ]));
  }

  Widget _profilePageUI() {
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return StreamBuilder<Contact>(
          stream: DBService.instance.getUserData(_auth.user.uid),
          builder: (_context, _snapshot) {
            var _userData = _snapshot.data;
            return _snapshot.hasData
                ? Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height:_height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 35,
                          ),
                          _userImageWidget(_userData.image),
                          _userNameWidget(_userData.name),
                          buildTextField("Full Name", _userData.name, false),
                          buildTextField("E-mail", _userData.email, false),
                          buildTextField("Password", "********", true),
                          SizedBox(
                            height: 35,
                          ),
                          _button(),
                        ],

                      ),
                    ),
                  )
                : SpinKitWanderingCubes(
                    color: Colors.blue,
                    size: 50.0,
                  );
          },
        );
      },
    );

  }

  Widget _userImageWidget(String _image) {
    double _imageRadius = 100;
    return Container(
      height: _imageRadius,
      width: _imageRadius,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_imageRadius),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(_image),
        ),
      ),
    );
  }

  Widget _userNameWidget(String _userName) {
    return Container(
      height: 50,
      width: _width,
      child: Text(
        _userName,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }
  Widget _button() {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
             MaterialButton(
              shape: StadiumBorder(),
              minWidth: 100,
              color: Colors.white12,
              child: new Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
          ),
          MaterialButton(
            shape: StadiumBorder(),
            minWidth: 100,
            color: Colors.blue,
            child: new Text("SAVE"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );



  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

}
