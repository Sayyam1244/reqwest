import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/categories_service.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class UserServices {
  static Future createUser({required Map<String, dynamic> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(data['docId'])
          .set(data, SetOptions(merge: true));
      return await getUser(docId: data['docId']);
    } catch (e) {
      return e.toString();
    }
  }

  static Future updateUser({required Map<String, dynamic> data}) async {
    try {
      // remove empty and null keys/values
      data.removeWhere((key, value) => value == null || value == '');
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update(data);
      return getUser();
    } catch (e) {
      return e.toString();
    }
  }

  static Future getUser({String? docId}) async {
    try {
      final res = await FirebaseFirestore.instance
          .collection('users')
          .where('docId', isEqualTo: docId ?? FirebaseAuth.instance.currentUser?.uid)
          .get();
      if (res.docs.isNotEmpty) {
        return UserModel.fromFirestore(res.docs.first);
      } else {
        throw "User not found";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future getAllUsers({String? docId}) async {
    try {
      final res = await FirebaseFirestore.instance.collection('users').get();
      return res.docs.map((e) => UserModel.fromFirestore(e)).toList();
    } catch (e) {
      return e.toString();
    }
  }

  static Stream<List<UserModel>> streamUsers({String userType = 'staff'}) async* {
    final categories = await CategoriesService.instance.getCategories();

    final res = FirebaseFirestore.instance.collection('users').where('role', isEqualTo: userType).snapshots();
    yield* res.map((event) {
      return event.docs.map((e) {
        final user = UserModel.fromFirestore(e);
        user.categoryModel = categories.where((e) => e.id == user.categoryId).firstOrNull;
        return user;
      }).toList();
    });
  }

  static Future uploadFile(File file) async {
    try {
      Reference ref =
          FirebaseStorage.instance.ref().child('profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(file);
      String link = await ref.getDownloadURL();

      return link;
    } catch (e) {
      log("uploadFile: $e");
      return "error: $e";
    }
  }
}
