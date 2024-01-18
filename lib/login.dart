import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/home-page.dart';
import 'auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late FirebaseAuth user;

  @override
  void initState() {
    super.initState();
    signOutGoogle();
  }

  void click() {
    signInWithGoogle().then((user) => {
          this.user = user,
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(user.currentUser!.displayName!)))
        });
  }

  Widget GoogleLoginButton() {
    return OutlinedButton(
        onPressed: this.click,
        child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(
                      image: AssetImage("assets/google-logo.png"), height: 35),
                  Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Sign in with Google",
                          style: TextStyle(color: Colors.grey, fontSize: 25)))
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Align(
          alignment: Alignment.center,
          child: GoogleLoginButton(),
        ));
  }
}
