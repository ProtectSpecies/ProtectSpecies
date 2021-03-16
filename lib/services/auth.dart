import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/fUser.dart';
import 'package:google_sign_in/google_sign_in.dart';



class AuthanticateServ {

  final FirebaseAuth _auth = FirebaseAuth.instance;


  /// create user obj based on User class ///

  FbUser _fUserFromUserClass(User user) {
    return user != null ? FbUser(uid: user.uid ): null;
  }


  /// auth change user stream ///

  Stream<FbUser> get user {
    return _auth.authStateChanges()
      .map((User user) => _fUserFromUserClass(user));
 }

 /// Sign Out ///

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  /// sign in anon ///

  Future signInAnon() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      //return user;
      return _fUserFromUserClass(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }



  /// register with email & password ///

  Future registerWithEmail(String email,String password) async {
    try{
       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
       User user = result.user;
       return _fUserFromUserClass(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

/// sign in with email & password ///

  Future signInWithEmail(String email,String password) async {
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _fUserFromUserClass(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  /// Sign in with Google ///

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



}


