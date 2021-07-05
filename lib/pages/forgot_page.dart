import 'package:chatify/providers/auth_provider.dart';
import 'package:chatify/services/loading.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  AuthProvider auth = AuthProvider();
  String _email, msg = "";
  final keys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: keys,
            child: Column(children: [
              Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 25),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (e) => _email = e,
                validator: (e) => e.isEmpty ? "Champ vide" : null,
                decoration: InputDecoration(
                    hintText: "Entrer votre email", labelText: "Email"),
              ),
              SizedBox(
                height: 10,
              ),
              RaisedButton(
                onPressed: () async {
                  if (keys.currentState.validate()) {
                    loading(context);
                    bool send = await auth.resetpassword(_email);
                    if (send) {
                      msg = "Check your mails";
                      Navigator.of(context).pop();
                      setState(() {});
                    }
                  }
                },
                child: Text("Send Email"),
              ),
              Text(
                msg,
                style: TextStyle(color: Colors.green),
              )
            ]),
          ),
        ),
      )),
    );
  }
}
