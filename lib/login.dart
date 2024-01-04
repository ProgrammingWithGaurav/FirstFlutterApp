import 'package:flutter/material.dart';
import 'package:myapp/home-page.dart';

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
  String name = "";
  TextEditingController controller = TextEditingController();

  void click() {
    this.name = controller.text;
    FocusScope.of(context).unfocus();
    controller.clear();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  this.name,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
          padding: EdgeInsets.all(10),
          child: TextField(
              controller: this.controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Type your name: ",
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 5, color: Colors.deepPurple)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.done),
                  splashColor: Colors.deepPurple,
                  tooltip: "Submit Name",
                  onPressed: this.click,
                ),
              ))),
    );
  }
}
