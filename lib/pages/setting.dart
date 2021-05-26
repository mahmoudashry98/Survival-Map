import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "setting",style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
