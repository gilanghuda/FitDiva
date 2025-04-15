import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitdiva/features/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; 

  Future<UserModel> register(String email, String password, String username) async {
    int retryCount = 0;
    const int maxRetries = 3;

    while (retryCount < maxRetries) {
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        final firebaseUser = userCredential.user;

        await firebaseUser!.updateDisplayName(username);

        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'username': username,
          'email': email,
        });

        return UserModel(
          id: firebaseUser.uid,
          username: username,
          email: firebaseUser.email!,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          throw Exception('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          throw Exception('An account already exists for that email.');
        } else if (e.code == 'network-request-failed') {
          retryCount++;
          if (retryCount >= maxRetries) {
            throw Exception('Network error: Failed to register user after multiple attempts.');
          }
          await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
        } else {
          throw Exception(e.message ?? 'An error occurred.');
        }
      } catch (e) {
        retryCount++;
        if (retryCount >= maxRetries) {
          throw Exception('Failed to register user after multiple attempts: ${e.toString()}');
        }
        await Future.delayed(const Duration(seconds: 2)); // Wait before retrying
      }
    }
    throw Exception('Unexpected error during registration.');
  }

  Future<UserModel> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final firebaseUser = userCredential.user;

    
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser!.uid).get();
      String username = userDoc['username'];
      if (!userDoc.exists) {
        throw Exception('User profile not found.');
      }

      return UserModel(
        id: firebaseUser.uid,
        username: username,
        email: firebaseUser.email!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw Exception('Gagal login, Cek koneksi internet anda');
      } else if (e.code == 'invalid-credential') {
        throw Exception('Kata sandi yang anda masukkan salah');
      } else {
        throw Exception('Authentication failed. Please try again.');
      }
    } catch (e) {
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }

  Future<UserModel> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign-in aborted');
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;

      DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser!.uid).get();
      if (!userDoc.exists) {


        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'username': firebaseUser.displayName,
          'email': firebaseUser.email,
        });
      } else {
      }

      return UserModel(
        id: firebaseUser.uid,
        username: firebaseUser.displayName!,
        email: firebaseUser.email!,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'sign_in_failed') {
        throw Exception('Google sign-in failed. Please check your configuration.');
      } else {
        throw Exception('Google sign-in failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('Google sign-in failed: ${e.toString()}');
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  Future<Map<String, String?>> getUserProfile() async {
    final User? user = _auth.currentUser;
    if (user == null) throw Exception('No user is currently signed in.');

    await user.reload();
    return {
      'name': user.displayName,
      'email': user.email,
    };
  }

  Future<UserModel> getCurrentUserProfile() async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) throw Exception('No user is currently signed in.');

    DocumentSnapshot userDoc = await _firestore.collection('users').doc(firebaseUser.uid).get();
    if (!userDoc.exists) throw Exception('User profile not found.');

    String username = userDoc['username'];

    return UserModel(
      id: firebaseUser.uid,
      username: username,
      email: firebaseUser.email!,
    );
  }

  Future<void> updateProfile(String username, String email, String? photoUrl) async {
    final User? firebaseUser = _auth.currentUser;
    if (firebaseUser == null) throw Exception('No user is currently signed in.');

    await firebaseUser.updateDisplayName(username);
    await firebaseUser.updateEmail(email);
    if (photoUrl != null) {
      await firebaseUser.updatePhotoURL(photoUrl);
    }

    await _firestore.collection('users').doc(firebaseUser.uid).update({
      'username': username,
      'email': email,
    });
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
}