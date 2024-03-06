
import 'package:demo1/pages/tabs/models/deco_user.dart';

import 'user_database_services.dart';

import 'package:firebase_auth/firebase_auth.dart';

/**********************************************************************
*    Title: Firebase Authentication Documentation
*    Author: Google Firebase
*    Date: 2022
*    Availability: https://firebase.google.com/docs/auth
*
**********************************************************************/

class AuthServices {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on FirebaseUser.
  DECOUser? _userFromFirebaseUser(User? user) {
    return user != null ? DECOUser(uid: user.uid, address: '', phoneNumber: 0, username: '') : null;
  }

  // Auth change user stream.
  Stream<DECOUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));    
  }

  // Sign out.
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // Register with email & password.
  registerEmailPassoword(String email, String password, String username) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? user = result.user;

    // Create a document of user information for this user in database.
    if (user != null) {
      await UserDatabaseServices(user.uid).updateUserData(username, 'not set', 'not set');
      return _userFromFirebaseUser(user);
    }
  }

  // Sign in with email and password.
  Future signInEmailPassoword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

  // Get current user information.
  User? getCurrentUserInfo() {
    try {
      User? result = _auth.currentUser;
      return (result);
    } catch(e) {
      // ignore: avoid_print
      print(e.toString());
      return null;
    }
  }

}