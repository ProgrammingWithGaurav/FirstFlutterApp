import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// signin function and return user
Future<FirebaseAuth> signInWithGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in to Firebase with the Google [UserCredential]
  final UserCredential userCredential =
      await auth.signInWithCredential(credential);
  
  return auth;
}

// signout function
Future<void> signOutGoogle() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  await googleSignIn.signOut();
  await auth.signOut();
}