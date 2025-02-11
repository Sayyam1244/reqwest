import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class MandateAgreementModel {
  String? docId;
  String? jobId;
  String? offerId;
  String? clientId;
  UserModel? clientUser;
  String? entrepreneurId;
  UserModel? entrepreneurUser;
  String? description;
  String? billingType;
  String pricingType;
  int mandateDurationId;
  double price;
  int? totalHours;
  Timestamp? startDate;
  Timestamp? endDate;
  String? additionalInfo;
  Timestamp? createdDate;
  String? status;
  List<RevisionNote>? revisionNotes;

  // Constructor with all the necessary fields
  MandateAgreementModel({
    this.docId,
    this.jobId,
    this.offerId,
    this.clientId,
    this.clientUser,
    this.entrepreneurId,
    this.entrepreneurUser,
    this.description,
    this.billingType,
    required this.pricingType,
    required this.mandateDurationId,
    required this.price,
    this.totalHours,
    this.startDate,
    this.endDate,
    this.additionalInfo,
    this.createdDate,
    this.status,
    this.revisionNotes,
  });

  // Factory constructor for creating MandateAgreementModel from Firestore DocumentSnapshot
  factory MandateAgreementModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return MandateAgreementModel(
      docId: snapshot.id,
      jobId: map['jobId'],
      offerId: map['offerId'],
      clientId: map['clientId'],
      clientUser: map['clientUser'] != null
          ? UserModel.fromJson(map['clientUser'])
          : null,
      entrepreneurId: map['entrepreneurId'],
      entrepreneurUser: map['entrepreneurUser'] != null
          ? UserModel.fromJson(map['entrepreneurUser'])
          : null,
      description: map['description'],
      billingType: map['billingType'],
      pricingType: map['pricingType'],
      mandateDurationId: map['mandateDurationId'],
      price: map['price']?.toDouble() ?? 0.0, // Ensuring price is double
      totalHours: map['totalHours'] ?? 0, // Default value to 0 if not present
      startDate:
          map['startDate'] != null ? map['startDate'] as Timestamp : null,
      endDate: map['endDate'] != null ? map['endDate'] as Timestamp : null,
      additionalInfo: map['additionalInfo'],
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as Timestamp : null,
      status: map['status'],
      revisionNotes: map['revisionNotes'] != null
          ? (map['revisionNotes'] as List)
              .map((note) => RevisionNote.fromMap(note))
              .toList()
          : null,
    );
  }

  // Factory constructor for creating MandateAgreementModel from a Map
  factory MandateAgreementModel.fromMap(Map<String, dynamic> map) {
    return MandateAgreementModel(
      docId: map['docId'],
      jobId: map['jobId'],
      offerId: map['offerId'],
      clientId: map['clientId'],
      clientUser: map['clientUser'] != null
          ? UserModel.fromJson(map['clientUser'])
          : null,
      entrepreneurId: map['entrepreneurId'],
      entrepreneurUser: map['entrepreneurUser'] != null
          ? UserModel.fromJson(map['entrepreneurUser'])
          : null,
      description: map['description'],
      billingType: map['billingType'],
      pricingType: map['pricingType'],
      mandateDurationId: map['mandateDurationId'],
      price: map['price']?.toDouble() ?? 0.0, // Ensuring price is double
      totalHours: map['totalHours'] ?? 0, // Default value to 0 if not present
      startDate:
          map['startDate'] != null ? map['startDate'] as Timestamp : null,
      endDate: map['endDate'] != null ? map['endDate'] as Timestamp : null,
      additionalInfo: map['additionalInfo'],
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as Timestamp : null,
      status: map['status'],
      revisionNotes: map['revisionNotes'] != null
          ? (map['revisionNotes'] as List)
              .map((note) => RevisionNote.fromMap(note))
              .toList()
          : null,
    );
  }

  // Convert object to Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'jobId': jobId,
      'offerId': offerId,
      'clientId': clientId,
      'clientUser': clientUser?.toMap(),
      'entrepreneurId': entrepreneurId,
      'entrepreneurUser': entrepreneurUser?.toMap(),
      'description': description,
      'billingType': billingType,
      'pricingType': pricingType,
      'mandateDurationId': mandateDurationId,
      'price': price,
      'totalHours': totalHours,
      'startDate': startDate,
      'endDate': endDate,
      'additionalInfo': additionalInfo,
      'createdDate': createdDate,
      'status': status,
      'revisionNotes': revisionNotes?.map((note) => note.toMap()).toList(),
    };
  }

  // Method to create a copy with new or updated fields
  MandateAgreementModel copyWith({
    String? docId,
    String? jobId,
    String? offerId,
    String? clientId,
    UserModel? clientUser,
    String? entrepreneurId,
    UserModel? entrepreneurUser,
    String? description,
    String? billingType,
    String? pricingType,
    int? mandateDurationId,
    double? price,
    int? totalHours,
    Timestamp? startDate,
    Timestamp? endDate,
    String? additionalInfo,
    Timestamp? createdDate,
    String? status,
    List<RevisionNote>? revisionNotes,
  }) {
    return MandateAgreementModel(
      docId: docId ?? this.docId,
      jobId: jobId ?? this.jobId,
      offerId: offerId ?? this.offerId,
      clientId: clientId ?? this.clientId,
      clientUser: clientUser ?? this.clientUser,
      entrepreneurId: entrepreneurId ?? this.entrepreneurId,
      entrepreneurUser: entrepreneurUser ?? this.entrepreneurUser,
      description: description ?? this.description,
      billingType: billingType ?? this.billingType,
      pricingType: pricingType ?? this.pricingType,
      mandateDurationId: mandateDurationId ?? this.mandateDurationId,
      price: price ?? this.price,
      totalHours: totalHours ?? this.totalHours,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      createdDate: createdDate ?? this.createdDate,
      status: status ?? this.status,
      revisionNotes: revisionNotes ?? this.revisionNotes,
    );
  }
}

class RevisionNote {
  String? userId;
  String? note;
  Timestamp? createdDate;

  RevisionNote({
    this.userId,
    this.note,
    this.createdDate,
  });

  // Factory constructor for creating RevisionNote from a Map
  factory RevisionNote.fromMap(Map<String, dynamic> map) {
    return RevisionNote(
      userId: map['userId'],
      note: map['note'],
      createdDate:
          map['createdDate'] != null ? map['createdDate'] as Timestamp : null,
    );
  }

  // Convert RevisionNote to a Map for Firestore storage
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'note': note,
      'createdDate': createdDate,
    };
  }
}
