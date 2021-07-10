import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../providers/auth_provider.dart';

import '../services/db_service.dart';
import '../services/navigation_service.dart';
import '../pages/conversation_page.dart';

import '../models/contact.dart';




class SearchPage extends StatefulWidget {


  //SearchPage(this._height, this._width);

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  String _searchText;
  double _deviceHeight;
  double _deviceWidth;

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
    return Builder(
      builder: (BuildContext _context) {
        _auth = Provider.of<AuthProvider>(_context);
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _userSearchField(),
            _usersListView(),
          ],
        );
      },
    );
  }

  Widget _userSearchField() {
    return Container(
      height: 50,
      width: _deviceWidth,
      padding: EdgeInsets.all(10.0),
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
        if (_usersData != null) {
          _usersData.removeWhere((_contact) => _contact.id == _auth.user.uid);
          _usersData.removeWhere((_contact) => _contact.isUser == false);
        }
        return _snapshot.hasData
            ? Container(
            height: 285,
          child: ListView.builder(
            itemCount: _usersData.length,
            itemBuilder: (BuildContext _context, int _index) {
              var _userData = _usersData[_index];
              var _currentTime = DateTime.now();
              var _receiverID = _usersData[_index].id;
              var _isUserActive = !_userData.lastSeen.toDate().isBefore(
                _currentTime.subtract(
                  Duration(hours: 1),
                ),
              );
              return ListTile(
                onTap: () {
                  DBService.instance.createOrGetConversation(
                      _auth.user.uid, _receiverID,
                          (String _conversationID) async{
                        NavigationService.instance.navigateToRoute(
                          MaterialPageRoute(builder: (_context) {
                            return ConversationPage(
                                _conversationID,
                                _receiverID,
                                _userData.name,
                                _userData.image);
                          }),
                        );
                      });
                },
                title: Text(_userData.name),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(_userData.image),
                    ),
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    _isUserActive
                        ? Text(
                      "Active Now",
                      style: TextStyle(fontSize: 15),
                    )
                        : Text(
                      "Last Seen",
                      style: TextStyle(fontSize: 15),
                    ),
                    _isUserActive
                        ? Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    )
                        : Text(
                      timeago.format(
                        _userData.lastSeen.toDate(),
                      ),
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              );
            },
          ),
        )
            : SpinKitWanderingCubes(
          color: Colors.blue,
          size: 50.0,
        );
      },
    );
  }
}
