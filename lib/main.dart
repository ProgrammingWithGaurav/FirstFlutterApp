import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = "";

  void setText(String text){
    this.setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Hello World")),
    body: Column(children: <Widget>[TextInputWidget(this.setText), Text(this.text)]));
  }
}


class TextInputWidget extends StatefulWidget {
  final Function(String) callback;

  TextInputWidget(this.callback);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();

  @override
  void dispose(){
    // refreshing the controller when a state is change
    super.dispose();
    controller.dispose();
  }

  @override
  void click(){
    widget.callback(controller.text);
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
        return TextField(
                controller: this.controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.message),
                    labelText: "Type a message",
                    suffixIcon: IconButton(icon: Icon(Icons.send),
                    splashColor: Colors.deepPurple,
                    tooltip: "Post Message",
                    onPressed: this.click,
                    ),
                ));
  }
}
