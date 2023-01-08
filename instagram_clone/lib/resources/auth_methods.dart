import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth auth_ = FirebaseAuth.instance;
  final FirebaseFirestore firestore_ = FirebaseFirestore.instance;
  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        {
          //register the user
          UserCredential cred = await auth_.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          String photoUrl = await StorageMethods()
              .uploadImageToString('profilePics', file, false);
          //add user to database
          await firestore_.collection('users').doc(cred.user!.uid).set({
            'username': username,
            'uid': cred.user!.uid,
            'email': email,
            'bio': bio,
            'followers': [],
            'following': [],
            'photoUrl': photoUrl,
          });
          res = 'Succes';
        }
      }
    }
    // on FirebaseAuthException catch (err) {
    //   if (err.code == 'invalid-email') {
    //     res = 'The email is badly formated';
    //   } else if (err.code == 'weak-password') {
    //     res = 'The password should be at least 6 character long';
    //   }
    // }
    catch (err) {
      res = err.toString();
    }
    return res;
  }
}
