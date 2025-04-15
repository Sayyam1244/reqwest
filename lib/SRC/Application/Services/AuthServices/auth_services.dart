import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class AuthServices {
  AuthServices._();
  static final AuthServices instance = AuthServices._();
  UserModel? _userModel;

  UserModel? get userModel => _userModel;

  set userModel(UserModel? value) {
    _userModel = value;
  }

  Future login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return await UserServices.getUser();
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future createUser({
    required UserModel userModel,
  }) async {
    try {
      if (userModel.role == 'staff') {
        final res = await checkIfUserAlreadyInFirestoreAddedByAdmin(userModel.email);

        if (res is UserModel) {
          await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!);
          userModel.docId = FirebaseAuth.instance.currentUser?.uid;
          userModel.categoryId = res.categoryId;
          await overrideUserDetails(res.docId, userModel.toMap());
          return UserServices.getUser(docId: userModel.docId);
        } else if (res == false) {
          return 'User is not added by admin';
        } else {
          return res;
        }
      } else {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: userModel.email!, password: userModel.password!);
        userModel.docId = FirebaseAuth.instance.currentUser?.uid;
        return await UserServices.createUser(data: userModel.toMap());
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  Future checkIfUserAlreadyInFirestoreAddedByAdmin(email) async {
    try {
      final user =
          await FirebaseFirestore.instance.collection('users').where('email', isEqualTo: email).get();
      log("user: ${user.docs.first.id}");
      if (user.docs.isNotEmpty) {
        return UserModel.fromFirestore(user.docs.first);
      } else {
        return false;
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future overrideUserDetails(docId, newUserMap) async {
    try {
      log("docId: $docId");
      log("newUserMap: $newUserMap");
      await FirebaseFirestore.instance.collection('users').doc(docId).delete();
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(newUserMap['docId'])
          .set(newUserMap, SetOptions(merge: true));
    } catch (e) {
      return e.toString();
    }
  }
}
