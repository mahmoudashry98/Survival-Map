import 'package:chatify/models/conversation.dart';
import 'package:chatify/pages/recent_conversations_page.dart';
import 'package:chatify/pages/search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Contact {
  final String id;
  final String email;
  final String image;
  final Timestamp lastseen;
  final String name;

  Contact({this.id, this.email, this.name, this.image, this.lastseen});

  factory Contact.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;
    return Contact(
      id: _snapshot.documentID,
      lastseen: _data["lastSeen"],
      email: _data["email"],
      name: _data["name"],
      image: _data["image"],
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: Text(
              'Chat',
              style:TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20
              ),
            ),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.people),
                ),
                Tab(
                  icon: Icon(Icons.chat),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              RecentConversationsPage(),
              SearchPage(),
            ],
          ),
        ),
    );
  }
}
