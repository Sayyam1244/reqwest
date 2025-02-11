import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';

class AuthServices {
  static Future login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  static Future createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }
}
