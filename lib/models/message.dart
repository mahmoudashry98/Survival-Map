import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageType {
  Text,
  Image,
}

class Message {
  final String senderID;
  final String message;
  final String receiverID;
  final Timestamp timestamp;
  final MessageType type;

  Message({
    this.senderID,
    this.message,
    this.receiverID,
    this.timestamp,
    this.type});
}
