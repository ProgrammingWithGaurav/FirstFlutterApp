import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/db.dart';

class Post {
  String body;
  String author;
  Set usersLiked = {};
  DatabaseReference? _id;

  Post(this.body, this.author);

  void likePost(FirebaseAuth user) {
    if (this.usersLiked.contains(user.currentUser?.uid)) {
      this.usersLiked.remove(user.currentUser?.uid);
    } else {
      this.usersLiked.add(user.currentUser?.uid);
    }
    this.udpate();
  }

  void udpate() {
    updatePost(this, this._id!);
  }

  // setter for id
  void setId(DatabaseReference id) {
    this._id = id;
  }

  // getter for id
  String getId() {
    return this._id!.key as String;
  }

  // function to convert post object to json to store in database
  Map<String, dynamic> toJson() {
    return {
      'author': this.author,
      'usersLiked': this.usersLiked.toList(),
      'body': this.body,
    };
  }

  deletePost() {
    deleteMessage(this._id!.key as String);
  }
}

// function to create post object from json
Post createPost(record) {
  Map<String, dynamic> attributes = {
    'author': '',
    'usersLiked': [],
    'body': '',
  };
  record.forEach((key, value) => {
        attributes[key] = value,
      });
  Post post = new Post(attributes['body'], attributes['author']);
  post.usersLiked = new Set.from(attributes['usersLiked']);
  return post;
}
