import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/resources/storage_methods.dart';
import '../models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth auth_ = FirebaseAuth.instance;
  final FirebaseFirestore firestore_ = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = auth_.currentUser!;

    DocumentSnapshot snap =
        await firestore_.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

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

          model.User user = model.User(
            username: username,
            uid: cred.user!.uid,
            email: email,
            bio: bio,
            followers: [],
            following: [],
            photoUrl: photoUrl,
          );

          //add user to database
          await firestore_.collection('users').doc(cred.user!.uid).set(
                user.toJson(),
              );
          res = 'Succes';
        }
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await auth_.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "succes";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = "No accunt detected";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
