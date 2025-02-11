import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/job_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class OfferModel {
  String? docId;
  String? jobId;
  String? offerTo;
  String? userId;
  double? price;
  String? type;
  double? vat;
  String? contractDuration;
  int? contractDurationId;
  String? otherInfo;
  Timestamp? createdDate;
  String? offerStatus;
  bool? isActive;
  UserModel? userModel;
  JobModel? jobModel;
  String? contractType;
  int? hours;
  String? mandateId;
  DateTime? startDate;
  DateTime? endDate;
  int? durationAgreementId;

  OfferModel({
    this.mandateId,
    this.userModel,
    this.docId,
    this.jobId,
    this.offerTo,
    this.userId,
    this.price,
    this.type,
    this.vat,
    this.contractDuration,
    this.contractDurationId,
    this.otherInfo,
    this.createdDate,
    this.offerStatus,
    this.isActive,
    this.jobModel,
    this.contractType,
    this.hours,
    this.startDate,
    this.endDate,
    this.durationAgreementId,
  });

  OfferModel copyWith({
    UserModel? userModel,
    String? docId,
    String? jobId,
    String? offerTo,
    String? userId,
    double? price,
    String? type,
    double? vat,
    String? contractDuration,
    int? contractDurationId,
    String? otherInfo,
    Timestamp? createdDate,
    String? offerStatus,
    bool? isActive,
    JobModel? jobModel,
    String? contractType,
    int? hours,
    String? mandateId,
    DateTime? startDate,
    DateTime? endDate,
    int? durationAgreementId,
  }) {
    return OfferModel(
      mandateId: mandateId ?? this.mandateId,
      jobModel: jobModel ?? this.jobModel,
      userModel: userModel ?? this.userModel,
      docId: docId ?? this.docId,
      jobId: jobId ?? this.jobId,
      offerTo: offerTo ?? this.offerTo,
      userId: userId ?? this.userId,
      price: price ?? this.price,
      type: type ?? this.type,
      vat: vat ?? this.vat,
      contractDuration: contractDuration ?? this.contractDuration,
      contractDurationId: contractDurationId ?? this.contractDurationId,
      otherInfo: otherInfo ?? this.otherInfo,
      createdDate: createdDate ?? this.createdDate,
      offerStatus: offerStatus ?? this.offerStatus,
      isActive: isActive ?? this.isActive,
      contractType: contractType,
      hours: hours,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationAgreementId: durationAgreementId ?? this.durationAgreementId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mandateId': mandateId,
      'docId': docId,
      'jobId': jobId,
      'offerTo': offerTo,
      'userId': userId,
      'price': price,
      'type': type,
      'vat': vat,
      // 'contractDuration': contractDuration,
      // 'contractDurationId': contractDurationId,
      'otherInfo': otherInfo,
      'createdDate': createdDate ?? FieldValue.serverTimestamp(),
      'offerStatus': offerStatus, //pending, accepted, rejected
      'isActive': isActive ?? true,
      'contractType': contractType,
      'hours': hours,
      'startDate': startDate,
      'endDate': endDate,
      'durationAgreementId': durationAgreementId,
    };
  }

  factory OfferModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return OfferModel(
      docId: snapshot.id,
      mandateId: data['mandateId'],
      jobId: data['jobId'],
      offerTo: data['offerTo'],
      userId: data['userId'],
      price: data['price']?.toDouble(),
      type: data['type'],
      vat: data['vat']?.toDouble(),
      contractDuration: data['contractDuration'],
      contractDurationId: data['contractDurationId'],
      otherInfo: data['otherInfo'],
      createdDate: data['createdDate'],
      offerStatus: data['offerStatus'] ?? 'pending',
      isActive: data['isActive'],
      contractType: data['contractType'],
      hours: data['hours'],
      startDate: data['startDate'] == null
          ? null
          : (data['startDate'] as Timestamp).toDate(),
      endDate: data['endDate'] == null
          ? null
          : (data['endDate'] as Timestamp).toDate(),
      durationAgreementId: data['durationAgreementId'],
    );
  }
  factory OfferModel.fromMap(Map<String, dynamic> data) {
    return OfferModel(
      mandateId: data['mandateId'],
      contractType: data['contractType'],
      hours: data['hours'],
      docId: data['docId'],
      jobId: data['jobId'],
      offerTo: data['offerTo'],
      userId: data['userId'],
      price: data['price']?.toDouble(),
      type: data['type'],
      vat: data['vat']?.toDouble(),
      contractDuration: data['contractDuration'],
      contractDurationId: data['contractDurationId'],
      otherInfo: data['otherInfo'],
      createdDate: data['createdDate'] == null
          ? null
          : (data['createdDate'].runtimeType == Timestamp)
              ? data['createdDate']
              : Timestamp.fromMicrosecondsSinceEpoch(
                  data['createdDate']["_seconds"]),
      offerStatus: data['offerStatus'] ?? 'pending',
      isActive: data['isActive'],
      startDate: data['startDate'] == null
          ? null
          : (data['startDate'].runtimeType == Timestamp)
              ? (data['startDate'] as Timestamp).toDate()
              : DateTime.fromMillisecondsSinceEpoch(
                  data['startDate']["_seconds"]),
      endDate: data['endDate'] == null
          ? null
          : (data['endDate'].runtimeType == Timestamp)
              ? (data['endDate'] as Timestamp).toDate()
              : DateTime.fromMillisecondsSinceEpoch(
                  data['endDate']["_seconds"]),
      durationAgreementId: data['durationAgreementId'],
    );
  }
}
