import 'package:chatify/models/contact.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/db_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccount createState() => _MyAccount();
}

class _MyAccount extends State<MyAccount> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _imageController = TextEditingController();





  bool showPassword = false;

  List userProfileList = [];

  String userID ="";

  String _searchText;
  AuthProvider _auth;
  double _deviceHeight;
  double _deviceWidht;




  void initState(){
    super.initState();
    fetchUserInfo();
  }
  fetchDatabaseList()async{
    dynamic resultant =await DBService.instance.getUsersInDB(_searchText);
    if (resultant == null){
      print("Unable to retrive");
      setState(() {
        userProfileList =resultant;
      });
    }
  }
  fetchUserInfo() async{
    FirebaseUser getUser = await FirebaseAuth.instance.currentUser();
    userID =getUser.uid;
  }

  updateData(String _name, String _imageURL) async{
    await DBService.instance.updateUserList(userID, _name, _imageURL);
    fetchDatabaseList();
  }
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidht = MediaQuery.of(context).size.width;

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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: _deviceHeight ,
              child: ChangeNotifierProvider<AuthProvider>.value(
                value: AuthProvider.instance,
                child: _profilePageUI(),
              ),
            ),
          ]),
        ));
  }

  Widget _profilePageUI() {
    return Column(children: <Widget>[
      Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidht * 0.12),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Builder(
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
                              //height:_deviceHeight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                      height: 30,
                                      ),
                                  _userImageWidget(_userData.image),
                                  _userNameWidget(_userData.name),
                                  TextField(
                                    controller: _nameController,
                                    decoration: InputDecoration(hintText: 'Name'),
                                  ),
                                  buildTextField(
                                      "E-mail", _userData.email, false),

                                  SizedBox(
                                    width: _deviceWidht,
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
            ),
          ))
    ]);
  }

  Widget _userImageWidget(String _image) {
    double _imageRadius = 100;
    return Container(
      height: 100,
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
      height: _deviceHeight * 0.1,
      width: _deviceWidht,
      child: Text(
        _userName,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black, fontSize: 30),
      ),
    );
  }

  Widget _button() {
    return Row(
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
            submitAction(
              context
            );
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

  submitAction(BuildContext context) {
    updateData(_nameController.text,_imageController.text);
    _nameController.clear();
    _imageController.clear();


  }
}
