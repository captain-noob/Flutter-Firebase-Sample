import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/models/user.dart';
import 'package:flutter_firebase/service/database.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on firebase object

  User _userfromFirebaseUser(FirebaseUser user){
    if(user != null){
      return User(uid: user.uid);
    }else{
      return null;
    }
  }

  // change userstream on auth

  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map(_userfromFirebaseUser);
  }

  //signin anonymosusly

  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously(); //anon signin
      FirebaseUser user = result.user;  //user value
      return _userfromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signin email and pass
  Future signInWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
//      print("success");
      FirebaseUser user =result.user;
      return _userfromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and pass

  Future registerWithEmailandPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user =result.user;
      await DatabaseService(uid: user.uid).userUpdateData('0', 'New User', 100);
      return _userfromFirebaseUser(user);

    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //logout

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}