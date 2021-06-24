import 'package:chatify/models/contact.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchPage extends StatefulWidget {
  //SearchPage(this._height, this._width);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  double _deviceHeight;
  double _deviceWidth;
  String _searchText;
  AuthProvider _auth;

  _SearchPageState() {
    _searchText = '';
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: ChangeNotifierProvider<AuthProvider>.value(
        value: AuthProvider.instance,
        child: _searchPageUI(),
      ),
    );
  }

  Widget _searchPageUI() {
    return Builder(builder: (BuildContext _context) {
      _auth = Provider.of<AuthProvider>(_context);
      return SingleChildScrollView(
          child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          _userSearchField(),
          _usersListView(),
        ],
      )
      );
    }
    );
  }

  Widget _userSearchField() {
    return Container(
      height: _deviceHeight * 0.08,
      width: _deviceWidth,
      padding: EdgeInsets.all(5.0),
      child: TextField(
        autocorrect: false,
        style: TextStyle(color: Colors.black),
        onSubmitted: (_input) {
          setState(() {
            _searchText = _input;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          labelStyle: TextStyle(color: Colors.black),
          labelText: "Search",
        ),
      ),
    );
  }

  Widget _usersListView() {
    return StreamBuilder<List<Contact>>(
        stream: DBService.instance.getDoctorsInDB(_searchText),
        builder: (_context, _snapshot) {
          var _doctorsData = _snapshot.data;
          return _snapshot.hasData
              ? Column(
                  children: <Widget>[
                    SingleChildScrollView(
                      child: Container(
                          height: _deviceHeight * 0.60,
                          width: _deviceWidth,
                          padding: EdgeInsets.all(10.0),
                          child: ListView.builder(
                              itemCount: _doctorsData.length,
                              itemBuilder: (BuildContext _context, int _index) {
                                var _doctorData = _doctorsData[_index];
                                var _currentTime = DateTime.now();
                                var _isDoctorActive = _doctorData.lastseen
                                    .toDate()
                                    .isBefore(_currentTime.subtract(
                                      Duration(hours: 1),
                                    ));
                                return ListTile(
                                  title: Text(_doctorData.name),
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(
                                                _doctorData.image))),
                                  ),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      _isDoctorActive
                                          ? Text(
                                              "Active now",
                                              style: TextStyle(fontSize: 15),
                                            )
                                          : Text(
                                              "Last Seen",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                      _isDoctorActive
                                          ? Container(
                                              height: 10,
                                              width: 10,
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            )
                                          : Text(
                                              timeago.format(
                                                _doctorData.lastseen.toDate(),
                                              ),
                                              style: TextStyle(fontSize: 15),
                                            )
                                    ],
                                  ),
                                );
                              })),
                    )
                  ],
                )
              : SpinKitWanderingCubes(
                  color: Colors.blue,
                  size: 50.0,
                );
        });
  }
}
