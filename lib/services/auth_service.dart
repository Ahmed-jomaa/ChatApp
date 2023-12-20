import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //instance of the auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // instance of fire store
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //signin method
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    //add new document for the user if it's not exist
    _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
    }, SetOptions(merge: true));
    return userCredential;
  }

  //create new user
  Future<UserCredential> rigesterUser(String email, String password) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // after creating the user, create a new document for the user in the users collections
    _firebaseFirestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
    });
    return userCredential;
  }

  //signout method
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
