// import 'package:chatify/pages/home_page_doctor.dart';
// import 'package:chatify/pages/registration_doctor_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/auth_provider.dart';
// import '../services/snackbar_service.dart';
// import '../services/navigation_service.dart';
// import '../pages/forgot_page.dart';
// import '../pages/login_doctors_page.dart';
//
// class LoginDoctorPage extends StatefulWidget {
//   @override
//   _LoginDoctorPageState createState() => _LoginDoctorPageState();
// }
//
// class _LoginDoctorPageState extends State<LoginDoctorPage> {
//   bool passwordVisible = true;
//   double _deviceHeight;
//   double _deviceWidht;
//
//   GlobalKey<FormState> _formkey;
//   AuthProvider _auth;
//   String _email;
//   String _password;
//
//   _LoginDoctorPageState() {
//     _formkey = GlobalKey<FormState>();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidht = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).backgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                 image: AssetImage("lib/ima/SC4.jpeg"),
//                 fit: BoxFit.fill,
//               )),
//               child: Align(
//                 alignment: Alignment.center,
//                 child: ChangeNotifierProvider<AuthProvider>.value(
//                   value: AuthProvider.instance,
//                   child: _loginPageUI(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _loginPageUI() {
//     return Builder(
//       builder: (BuildContext _context) {
//         SnackBarService.instance.buildContext = _context;
//         _auth = Provider.of<AuthProvider>(_context);
//         return Container(
//           height: _deviceHeight * 1.0,
//           padding: EdgeInsets.symmetric(horizontal: _deviceWidht * 0.12),
//           alignment: Alignment.center,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             mainAxisSize: MainAxisSize.max,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               _headingWidget(),
//               _inputForm(),
//               _registerButton(),
//               _loginButton(),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _headingWidget() {
//     return Container(
//       height: _deviceHeight * 0.15,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.max,
//         children: <Widget>[
//           Text(
//             "   Welcome,",
//             style: TextStyle(
//                 fontSize: 35, fontWeight: FontWeight.w700, color: Colors.white),
//           ),
//           Text(
//             "Sign in to Continue!",
//             style: TextStyle(
//                 fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _inputForm() {
//     return Container(
//       height: _deviceHeight * 0.25,
//       width: _deviceWidht * 0.80,
//       child: Form(
//         key: _formkey,
//         onChanged: () {
//           _formkey.currentState.save();
//         },
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//                 child: Text(
//               "Login..",
//               style: TextStyle(
//                 fontSize: 25,
//                 fontWeight: FontWeight.w900,
//                 color: Colors.blue,
//               ),
//             )),
//             _emailTextField(),
//             _PasswordTextField(),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _emailTextField() {
//     return Container(
//       child: Card(
//           margin: EdgeInsets.all(18),
//           color: Color.fromRGBO(208, 211, 212, 1),
//           child: TextFormField(
//             autocorrect: false,
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
//             validator: (_input) {
//               return _input.length != 0 && _input.contains("@")
//                   ? null
//                   : "Please enter a valid email";
//             },
//             onSaved: (_input) {
//               setState(() {
//                 _email = _input;
//               });
//             },
//             keyboardType: TextInputType.emailAddress,
//             decoration: InputDecoration(
//               hintText: "Email Address...",
//               hintStyle: TextStyle(fontSize: 20, color: Colors.white),
//               prefixIcon: Icon(
//                 Icons.account_circle_rounded,
//                 color: Colors.black,
//               ),
//             ),
//           )),
//     );
//   }
//
//   // ignore: non_constant_identifier_names
//   Widget _PasswordTextField() {
//     return Column(
//       children: [
//         Center(
//           child: Card(
//             margin: EdgeInsets.all(18),
//             color: Color.fromRGBO(208, 211, 212, 1),
//             child: TextFormField(
//               autocorrect: false,
//               obscureText: passwordVisible,
//               style: TextStyle(color: Colors.black),
//               // ignore: missing_return
//               validator: (_input) {
//                 return _input.length != 0 ? null : "Please enter a password";
//               },
//               onSaved: (_input) {
//                 setState(() {
//                   _password = _input;
//                 });
//               },
//               cursorColor: Colors.white,
//               decoration: InputDecoration(
//                   hintText: "Password...",
//                   hintStyle: TextStyle(
//                     fontSize: 20,
//                     color: Colors.white,
//                   ),
//                   suffixIcon: IconButton(
//                     icon: Icon(passwordVisible
//                         ? Icons.visibility
//                         : Icons.visibility_off),
//                     onPressed: () {
//                       setState(() {
//                         passwordVisible = !passwordVisible;
//                       });
//                     },
//                   ),
//                   prefixIcon: Icon(
//                     Icons.lock,
//                     color: Colors.black,
//                   )),
//             ),
//           ),
//         ),
//         Container(
//           width: double.infinity,
//           child: InkWell(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => ForgotScreen()));
//               },
//               child: Text(
//                 "Forgot password ? ",
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 15,
//                     fontWeight: FontWeight.w400),
//                 textAlign: TextAlign.end,
//               )),
//         ),
//
//       ],
//     );
//   }
//
//   Widget _loginButton() {
//     return _auth.status == AuthStatus.Authenticating
//         ? Align(
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(),
//           )
//         : Container(
//             padding: EdgeInsets.symmetric(horizontal: 90),
//             height: _deviceHeight * 0.06,
//             width: _deviceWidht,
//             child: MaterialButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20)),
//               onPressed: () {
//                 if (_formkey.currentState.validate()) {
//                   _auth.loginUserWithEmailAndPassword(_email, _password);
//                   // login user
//                 }
//               },
//               color: Colors.white,
//               child: Text(
//                 "Sign In"
//                 "",
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.blue),
//               ),
//             ));
//   }
//
//   Widget _registerButton() {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (BuildContext context) => RegistrationDoctorPage()));
//       },
//       child: Column(
//         children: [
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 58),
//             height: _deviceHeight * 0.05,
//             child: Text(
//               "You Don’t Have An Account ?",
//               style: TextStyle(
//                   fontSize: 15,
//                   fontWeight: FontWeight.w600,
//                   color: Colors.blue),
//             ),
//           ),
//           Container(
//             height: _deviceHeight * 0.15,
//             child: Text(
//               "REGISTER",
//               textAlign: TextAlign.end,
//               style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.blue),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
