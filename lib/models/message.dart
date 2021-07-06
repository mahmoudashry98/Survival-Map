import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  Text,
  Image,
}

class Message {
  final String senderID;
  final String content;
  final String receiverID;
  final Timestamp timestamp;
  final MessageType type;

  Message({
    this.senderID,
    this.content,
    this.receiverID,
    this.timestamp,
    this.type});
}

