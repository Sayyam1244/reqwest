import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String fullName;
  String? docId;
  String? businessId;
  String? profilePhoto;
  Timestamp? creationTime;
  bool isActive;
  bool isBlocked;
  String? phoneNumber;

  // Constructor
  UserModel({
    this.email,
    required this.fullName,
    this.docId,
    this.businessId,
    this.phoneNumber,
    this.profilePhoto,
    this.creationTime,
    required this.isActive,
    required this.isBlocked,
  });

  // Factory method to create a UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      email: data['email'],
      fullName: data['fullName'],
      docId: doc.id, // This is the document ID from Firestore
      businessId: data['businessId'],
      phoneNumber: data['phoneNumber'],
      profilePhoto: data['profilePhoto'],
      creationTime: data['creationTime'],
      isActive: data['isActive'] ?? true,
      isBlocked: data['isBlocked'] ?? false,
    );
  }
  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      email: data['email'],
      fullName: data['fullName'],
      phoneNumber: data['phoneNumber'],
      docId: data['docId'],
      businessId: data['businessId'],
      profilePhoto: data['profilePhoto'],
      creationTime: Timestamp.fromMicrosecondsSinceEpoch(
          data['creationTime']['_seconds']),
      isActive: data['isActive'] ?? true,
      isBlocked: data['isBlocked'] ?? false,
    );
  }

  // Method to convert the UserModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'businessId': businessId,
      'profilePhoto': profilePhoto,
      'creationTime': FieldValue.serverTimestamp(),
      'isActive': isActive,
      'isBlocked': isBlocked,
    };
  }
}
