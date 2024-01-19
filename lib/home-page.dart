import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/db.dart';
import 'post.dart';
import 'post-list.dart';
import 'text-input.dart';

class MyHomePage extends StatefulWidget {
  final FirebaseAuth user;

  MyHomePage(this.user);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];

  void newPost(String text) {
    this.setState(() {
      var post = new Post(text, widget.user.currentUser?.displayName as String);
      savePost(post);
      post.setId(savePost(post));
      posts.add(post);
    });
  }

  void updatePosts() {
    getAllMessages().then((posts) => {
          this.setState(() {
            this.posts = posts;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    updatePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts, widget.user)),
          TextInputWidget(this.newPost),
        ]));
  }
}
