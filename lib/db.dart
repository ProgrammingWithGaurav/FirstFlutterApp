import 'package:firebase_core/firebase_core.dart';
import 'post.dart';
import 'package:firebase_database/firebase_database.dart';

// final dbRef = FirebaseDatabase.instance.ref();
DatabaseReference dbRef = FirebaseDatabase.instanceFor(
        app: Firebase.app(),
        databaseURL:
            'https://fluttermessageapp-7820f-default-rtdb.asia-southeast1.firebasedatabase.app/')
    .ref();

DatabaseReference savePost(Post post) {
  var id = dbRef.child('posts/').push();
  id.set(post.toJson());
  return id;
}

void updatePost(Post post, DatabaseReference id) {
  id.update(post.toJson());
}

Future<List<Post>> getAllMessages() async {
  DatabaseEvent dataSnapshot = await dbRef.child('posts/').once();
  List<Post> posts = [];
  if (dataSnapshot.snapshot.value != null) {
    (dataSnapshot.snapshot.value as Map<dynamic, dynamic>)
        .forEach((key, value) {
      var post = createPost(value);
      post.setId(dbRef.child('posts/' + key));
      posts.add(post);
    });
  }
  return posts;
}

// function to delete message with given id
void deleteMessage(String id) {
  dbRef.child('posts/' + id).remove();
}
