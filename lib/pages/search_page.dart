import 'package:chatify/models/contact.dart';
import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class SearchPage extends StatefulWidget {
   double _height;
   double _width;

   SearchPage(this._height, this._width);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchText;

  AuthProvider _auth;
  _SearchPageState() {
    _searchText = '';
  }

  @override
  Widget build(BuildContext context) {
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
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _userSearchField(),
          _usersListView()
        ],
      );
    });
  }

  Widget _userSearchField() {
    return Container(
      height: this.widget._height,
      width: this.widget._width,
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
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget _usersListView() {
    return StreamBuilder<List<Contact>>(
        stream: DBService.instance.getUsersInDB(_searchText),
        builder: (_context, _snapshot) {
          var _usersData = _snapshot.data;
          return _snapshot.hasData ?
          Container(
            height: this.widget._height,
            child: ListView.builder(
                itemCount: _usersData.length,
                itemBuilder: (BuildContext _context, int _index) {
                  var _userdata = _usersData[_index];
                  return ListTile(
                      title: Text(_userdata.name),
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    _userdata.image))),
                      ),
                      trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "last seen",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              "About an hour ago",
                              style: TextStyle(fontSize: 15),
                            )
                          ]
                      )
                  );
                }
            ),
          ) : SpinKitWanderingCubes(
            color: Colors.blue,
            size: 50,
          );
        }
        );
  }
}
