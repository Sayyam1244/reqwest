import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';

class CategoriesService {
  CategoriesService._privateConstructor();
  static final CategoriesService instance = CategoriesService._privateConstructor();
  factory CategoriesService() => instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<CategoryModel>? _cachedCategories;

  List<CategoryModel>? get cachedCategories => _cachedCategories;

  set cachedCategories(List<CategoryModel>? value) {
    _cachedCategories = value;
  }

  Future<List<CategoryModel>> getCategories() async {
    final QuerySnapshot querySnapshot = await _firestore.collection('categories').get();
    _cachedCategories =
        querySnapshot.docs.map((doc) => CategoryModel.fromJson(doc.data() as Map<String, dynamic>)).toList();
    return _cachedCategories ?? [];
  }

  Future uploadImage(File file) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child('images/$fileName.jpg');
    await reference.putFile(file);
    return await reference.getDownloadURL();
  }

  Future uploadImage2(Uint8List file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child('images/$fileName.jpg');
      await reference.putData(file);

      return await reference.getDownloadURL();
    } catch (e) {
      log('Error uploading image: $e');
      rethrow;
    }
  }

  Future addCategory(CategoryModel category, Uint8List? file) async {
    try {
      if (file != null) {
        final String imageUrl = await uploadImage2(file);
        category.image = imageUrl;
      }

      final docRef = _firestore.collection('categories').doc(category.id);

      category.id = docRef.id;

      await docRef.set(category.toDocument(), SetOptions(merge: true));

      return true;
    } catch (e) {
      log('Error adding category: $e');
      return e.toString();
    }
  }

  Future<CategoryModel?> getCategoryById(String id) async {
    final docSnapshot = await _firestore.collection('categories').doc(id).get();
    if (docSnapshot.exists) {
      return CategoryModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  Stream<List<CategoryModel>> streamCategories() {
    return _firestore.collection('categories').snapshots().map((querySnapshot) {
      return querySnapshot.docs.map((doc) => CategoryModel.fromJson(doc.data())).toList();
    });
  }
  // Future<void> updateCategory(Category category) async {
  //   await _firestore
  //       .collection('categories')
  //       .doc(category.id)
  //       .update(category.toDocument());
  // }

  // Future<void> deleteCategory(Category category) async {
  //   await _firestore.collection('categories').doc(category.id).delete();
  // }
}
