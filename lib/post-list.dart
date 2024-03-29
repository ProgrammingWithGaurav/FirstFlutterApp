import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';

class PostList extends StatefulWidget {
  final List<Post> listItems;
  final FirebaseAuth user;

  PostList(this.listItems, this.user);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Container(
              child: CircleAvatar(
                backgroundImage: NetworkImage(post.profilePic),
              ),
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
          Expanded(
              child: ListTile(
            title: Text(post.body),
            subtitle: Text(post.author),
          )),
          Row(children: <Widget>[
            Container(
              child: Text(post.usersLiked.length.toString(),
                  style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            ),
            IconButton(
                icon: Icon(
                  Icons.thumb_up,
                  color: post.usersLiked.contains(widget.user.currentUser?.uid)
                      ? Colors.deepOrange[400]
                      : Colors.grey,
                ),
                onPressed: () => this.like(() => post.likePost(widget.user))),
            // render delete button if author of post is current user
            post.author == widget.user.currentUser?.displayName
                ? IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red[300],
                    splashColor: Colors.red,
                    onPressed: () => {
                      this.setState(() {
                        post.deletePost();
                        this.widget.listItems.removeAt(index);
                      })
                    },
                  )
                : Container(),
          ])
        ]));
      },
    );
  }
}
