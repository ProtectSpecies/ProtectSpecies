import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterapp/models/fUser.dart';

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
      print("Signed in");
      //return user;
      return _fUserFromUserClass(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }



  /// sign in with email & password ///

  /// register with email & password ///



}

