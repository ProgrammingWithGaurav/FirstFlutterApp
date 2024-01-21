import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
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
      var post = new Post(text, widget.user.currentUser?.displayName as String,
          widget.user.currentUser?.photoURL as String);
      DatabaseReference id = savePost(post);
      post.setId(id);
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
      appBar: AppBar(
        title: Text("Messages"),
      ),
      body: Container(
          child: Column(children: <Widget>[
            Expanded(child: PostList(this.posts, widget.user)),
            TextInputWidget(this.newPost),
          ]),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(
                      'https://source.unsplash.com/1600x900/?wallpaper')
                  .image,
              fit: BoxFit.cover,
              // lower the z-index of the image
            ),
          )),
    );
  }
}
