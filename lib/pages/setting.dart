import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        textTheme: TextTheme(),
        title: Text(
          "Settings",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
        ),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
            ),
            items: [
              DropdownMenuItem(
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 8,
                    ),
                    Text("Logout"),
                  ],
                ),
                value: "logout",
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
        centerTitle: true,
      ),
    );
  }
}
