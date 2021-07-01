
import 'package:chatify/pages/my_account.dart';
import 'package:chatify/pages/profile/components/profile_menu.dart';
import 'package:chatify/services/navigation_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingUserPage extends StatelessWidget {
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
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2020/07/01/12/58/icon-5359553_960_720.png",
                              ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              SizedBox(
                height: 35,
              ),
              ProfileMenu(
                text: "My Account",
                icon: "assets/icons/User Icon.svg",
                press: () => {
                  Navigator.pushNamed(context, "MyAccount")
                },
              ),
              ProfileMenu(
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {
                  launch('https://www.who.int/ar/emergencies/diseases/novel-coronavirus-2019/advice-for-public');
                },
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/icons/Log out.svg",
                press: () {
                  FirebaseAuth.instance.signOut();
                  NavigationService.instance.navigateToReplacement("login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
