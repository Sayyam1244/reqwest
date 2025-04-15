import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';

class UserModel {
  String? email;
  String? firstName;
  String? lastName;
  String? docId;
  String? phoneNumber;
  String? password;
  String? role;
  String? categoryId;
  CategoryModel? categoryModel;

  // Constructor
  UserModel({
    this.email,
    this.docId,
    this.firstName,
    this.phoneNumber,
    this.lastName,
    this.password,
    this.role,
    this.categoryId,
    this.categoryModel,
  });

  // Factory method to create a UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      docId: doc.id,
      role: data['role'],
      categoryId: data['categoryId'],
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      firstName: data['firstName'],
      lastName: data['lastName'],
      phoneNumber: data['phoneNumber'],
      docId: data['docId'],
      role: data['role'],
      categoryId: data['categoryId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'creationTime': FieldValue.serverTimestamp(),
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'docId': docId,
      'role': role,
      'categoryId': categoryId,
    };
  }

  UserModel copyWith({
    String? email,
    String? firstName,
    String? lastName,
    String? docId,
    String? phoneNumber,
    String? password,
    String? role,
    String? categoryId,
    CategoryModel? categoryModel,
  }) {
    return UserModel(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      docId: docId ?? this.docId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      role: role ?? this.role,
      categoryId: categoryId ?? this.categoryId,
      categoryModel: categoryModel ?? this.categoryModel,
    );
  }
}
