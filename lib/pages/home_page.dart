import 'package:chatify/models/conversation.dart';
import 'package:chatify/pages/map_page.dart';
import 'package:flutter/material.dart';
import '../pages/recent_conversations_page.dart';
import '../pages/map_page.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  List<Widget> _pages = [
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Map',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ),
    DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Chat',
            style: TextStyle(fontWeight: FontWeight.w600),
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
            Conversation(),

          ],
        ),
      ),
    ),
    Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Setting',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    ),
  ];
  int _selectedPageIndex = 0;
  void _x1(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: _pages[_selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          currentIndex: _selectedPageIndex,
          selectedFontSize: 15,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: _x1,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              title: Text('Map'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              title: Text('Chat'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Setting'),
            ),
          ],
        ),
      ),
    );
  }
}
