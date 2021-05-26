import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  const Message({Key key}) : super(key: key);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "massage",style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
