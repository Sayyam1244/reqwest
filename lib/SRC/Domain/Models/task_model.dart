// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  String? requestedBy;
  String? docId;
  DateTime? createdDate;
  String? assignTo;
  String? status;
  String? category;
  String? service;
  String? email;
  String? phone;
  String? description;
  UserModel? requestedByUser;
  UserModel? assignToUser;
  CategoryModel? categoryModel;

  TaskModel({
    this.categoryModel,
    this.requestedBy,
    this.docId,
    this.createdDate,
    this.assignTo,
    this.status,
    this.category,
    this.service,
    this.email,
    this.phone,
    this.description,
    this.requestedByUser,
    this.assignToUser,
  });

  TaskModel copyWith({
    CategoryModel? categoryModel,
    String? requestedBy,
    String? docId,
    DateTime? createdDate,
    String? assignTo,
    String? status,
    String? category,
    String? service,
    String? email,
    String? phone,
    String? description,
    UserModel? requestedByUser,
    UserModel? assignToUser,
  }) =>
      TaskModel(
        categoryModel: categoryModel ?? this.categoryModel,
        requestedBy: requestedBy ?? this.requestedBy,
        docId: docId ?? this.docId,
        createdDate: createdDate ?? this.createdDate,
        assignTo: assignTo ?? this.assignTo,
        status: status ?? this.status,
        category: category ?? this.category,
        service: service ?? this.service,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        description: description ?? this.description,
        requestedByUser: requestedByUser ?? this.requestedByUser,
        assignToUser: assignToUser ?? this.assignToUser,
      );

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        requestedBy: json["requestedBy"],
        docId: json["docId"],
        createdDate: (json["createdDate"] as Timestamp).toDate(),
        assignTo: json["assignTo"],
        status: json["status"],
        category: json["category"],
        service: json["service"],
        email: json["email"],
        phone: json["phone"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "requestedBy": requestedBy,
        "docId": docId,
        "createdDate": Timestamp.fromDate(createdDate!),
        "assignTo": assignTo,
        "status": status,
        "category": category,
        "service": service,
        "email": email,
        "phone": phone,
        "description": description,
      };
}
