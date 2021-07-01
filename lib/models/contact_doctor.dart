// import '../pages/recent_conversations_doctor_page.dart';
//
// import '../pages/recent_conversations_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
//
// class ContactDoctor {
//   final String id;
//   final String email;
//   final String image;
//   final Timestamp lastseen;
//   final String name;
//
//   ContactDoctor({this.id, this.email, this.name, this.image, this.lastseen});
//
//   factory ContactDoctor.fromFirestore(DocumentSnapshot _snapshot) {
//     var _data = _snapshot.data;
//     return ContactDoctor(
//       id: _snapshot.documentID,
//       lastseen: _data["lastSeen"],
//       email: _data["email"],
//       name: _data["name"],
//       image: _data["image"],
//     );
//   }
// }
//
// class ChatPageDoctor extends StatefulWidget {
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends State<ChatPageDoctor>
//     with SingleTickerProviderStateMixin{
//   double _height;
//   double _width;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 1,
//       child:Scaffold(
//           appBar: AppBar(
//             backgroundColor: Colors.blue,
//             centerTitle: true,
//             title: Text(
//               'Chat',
//               style:TextStyle(
//                   color: Colors.white,fontWeight: FontWeight.w600,fontSize: 20
//               ),
//             ),
//             bottom: TabBar(
//               tabs: <Widget>[
//                 Tab(
//                   icon: Icon(Icons.chat),
//                 ),
//               ],
//             ),
//           ),
//           body: _tabBarPages()
//       ),
//     );
//   }
//
//   Widget _tabBarPages(){
//     return TabBarView(
//       children: <Widget>[
//         RecentConversationsDoctorPage(_height, _width)
//
//
//
//       ],
//     );
//   }
//
//
// }
