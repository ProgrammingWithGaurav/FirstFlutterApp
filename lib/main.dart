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

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(appBar: AppBar(title: Text("Hello World")),
    body: TextInputWidget()

    );
  }
}

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({super.key});

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final controller = TextEditingController();
  String text = "";

  @override
  void dispose(){
    // refreshing the controller when a state is change
    super.dispose();
    controller.dispose();
  }

  void setText(text){
    if(text == "hello"){
      controller.clear();
      text = "";
    }
    setState(() {
      this.text = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          TextField(
                controller: this.controller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.message),
                    labelText: "Type a message"
                ),
                onChanged: (text) => setText(text),
          ),
        Text(this.text),
        ]
    );
  }
}
