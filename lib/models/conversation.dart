import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Conversations extends StatefulWidget {
  @override
  _ConversationsState createState() => _ConversationsState();
}

class _ConversationsState extends State<Conversations> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ConversationSnippet {
  final String id;
  final String conversationID;
  final String lastMessage;
  final String name;
  final String image;
  final int unseenCount;
  final Timestamp timestamp;

  ConversationSnippet(
      {this.conversationID,
        this.id,
        this.lastMessage,
        this.unseenCount,
        this.timestamp,
        this.name,
        this.image,
        });

  factory ConversationSnippet.fromFirestore(DocumentSnapshot _snapshot) {
    var _data = _snapshot.data;

    if (_data["type"] != null) {
      switch (_data["type"]) {
        case "text":
          break;
        case "image":
          break;
        default:
      }
    }
    return ConversationSnippet(
      id: _snapshot.documentID,
      conversationID: _data["conversationID"],
      lastMessage: _data["lastMessage"] != null ? _data["lastMessage"] : "",
      unseenCount: _data["unseenCount"],
      timestamp: _data["timestamp"] != null ? _data["timestamp"] : null,
      name: _data["name"],
      image: _data["image"],

    );
  }
}

