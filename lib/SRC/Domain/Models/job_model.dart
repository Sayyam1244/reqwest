import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/offer_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class JobModel {
  String? docId;
  String? title;
  String? description;
  String? location;
  Timestamp? startDate;
  String? dateType;
  String? postedBy;
  bool? isActive;
  bool? isBlocked;
  String? jobImage;
  String? finalizedCandidateId;
  String? finalizedOfferId;
  String? mandateId;
  Timestamp? createdDate;
  String? jobStatus;
  UserModel? userModel;
  List<OfferModel>? offers;

  // Constructor
  JobModel({
    this.dateType,
    this.userModel,
    this.offers,
    this.docId,
    this.title,
    this.description,
    this.location,
    this.startDate,
    this.postedBy,
    this.isActive,
    this.isBlocked,
    this.jobImage,
    this.finalizedCandidateId,
    this.finalizedOfferId,
    this.mandateId,
    this.createdDate,
    this.jobStatus,
  });

  // copyWith method to create a copy of an object with some modified fields
  JobModel copyWith({
    String? dateType,
    String? docId,
    String? title,
    String? description,
    String? location,
    Timestamp? startDate,
    String? postedBy,
    bool? isActive,
    bool? isBlocked,
    String? jobImage,
    String? finalizedCandidateId,
    String? finalizedOfferId,
    String? mandateId,
    Timestamp? createdDate,
    String? jobStatus,
    UserModel? userModel,
    List<OfferModel>? offers,
  }) {
    return JobModel(
      dateType: dateType ?? this.dateType,
      userModel: userModel ?? this.userModel,
      offers: offers ?? this.offers,
      docId: docId ?? this.docId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      postedBy: postedBy ?? this.postedBy,
      isActive: isActive ?? this.isActive,
      isBlocked: isBlocked ?? this.isBlocked,
      jobImage: jobImage ?? this.jobImage,
      finalizedCandidateId: finalizedCandidateId ?? this.finalizedCandidateId,
      finalizedOfferId: finalizedOfferId ?? this.finalizedOfferId,
      mandateId: mandateId ?? this.mandateId,
      createdDate: createdDate ?? this.createdDate,
      jobStatus: jobStatus ?? this.jobStatus,
    );
  }

  // toMap function to convert the object to a Map (for Firestore saving)
  Map<String, dynamic> toMap() {
    return {
      "dateType": dateType,
      'docId': docId,
      'title': title,
      'description': description,
      'location': location,
      'startDate': startDate,
      'postedBy': postedBy,
      'isActive': isActive ?? true,
      'isBlocked': isBlocked ?? false,
      'jobImage': jobImage,
      'finalizedCandidateId': finalizedCandidateId,
      'finalizedOfferId': finalizedOfferId,
      'mandateId': mandateId,
      'createdDate': createdDate ?? FieldValue.serverTimestamp(),
      'jobStatus': jobStatus,
      "offers": offers?.map((e) => e.toMap()).toList(),
    };
  }

  // fromFirestore function to create a JobModel object from Firestore data
  factory JobModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;
    return JobModel(
      docId: snapshot.id,
      dateType: data['dateType'],
      title: data['title'],
      description: data['description'],
      location: data['location'],
      startDate: data['startDate'],
      postedBy: data['postedBy'],
      isActive: data['isActive'],
      isBlocked: data['isBlocked'],
      jobImage: data['jobImage'],
      finalizedCandidateId: data['finalizedCandidateId'],
      finalizedOfferId: data['finalizedOfferId'],
      mandateId: data['mandateId'],
      createdDate: data['createdDate'],
      jobStatus: data['jobStatus'],
    );
  }
  factory JobModel.fromMap(Map<String, dynamic> data) {
    return JobModel(
      dateType: data['dateType'],
      userModel: data['user'] != null ? UserModel.fromJson(data['user']) : null,
      offers: data['offers'] != null
          ? (data['offers'] as List).map((e) => OfferModel.fromMap(e)).toList()
          : null,
      docId: data['docId'],
      title: data['title'],
      description: data['description'],
      location: data['location'],
      startDate:
          Timestamp.fromMicrosecondsSinceEpoch(data['startDate']['_seconds']),
      postedBy: data['postedBy'],
      isActive: data['isActive'],
      isBlocked: data['isBlocked'],
      jobImage: data['jobImage'],
      finalizedCandidateId: data['finalizedCandidateId'],
      finalizedOfferId: data['finalizedOfferId'],
      mandateId: data['mandateId'],
      createdDate:
          Timestamp.fromMicrosecondsSinceEpoch(data['createdDate']['_seconds']),
      jobStatus: data['jobStatus'],
    );
  }
}
