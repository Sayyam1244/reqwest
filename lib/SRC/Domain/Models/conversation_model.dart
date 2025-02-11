import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/job_model.dart';
import 'package:reqwest/SRC/Domain/Models/mandate_agreement_model.dart';
import 'package:reqwest/SRC/Domain/Models/offer_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class ConversationModel {
  String? docId;
  List<String>? participants;
  String? jobBy;
  UserModel? jobByUser;
  String? offerBy;
  UserModel? offerByUser;

  String? jobId;
  JobModel? jobModel;
  String? offerId;
  OfferModel? offerModel;
  String? mandateId;
  MandateAgreementModel? mandateAgreementModel;
  Timestamp? createdDate;
  Timestamp? lastModified;
  String? content;
  String? chatAgreement;

  // Constructor
  ConversationModel({
    this.chatAgreement,
    this.content,
    this.docId,
    required this.participants,
    required this.jobId,
    required this.jobBy,
    required this.offerBy,
    required this.offerId,
    required this.mandateId,
    this.createdDate,
    this.lastModified,
    this.jobByUser,
    this.jobModel,
    this.mandateAgreementModel,
    this.offerByUser,
    this.offerModel,
  });

  // CopyWith method to create a new instance with modified values
  ConversationModel copyWith({
    String? docId,
    List<String>? participants,
    String? jobId,
    String? jobBy,
    String? offerBy,
    String? offerId,
    String? mandateId,
    Timestamp? createdDate,
    Timestamp? lastModified,
    String? content,
    String? chatAgreement,
  }) {
    return ConversationModel(
      content: content ?? this.content,
      docId: docId ?? this.docId,
      participants: participants ?? this.participants,
      jobId: jobId ?? this.jobId,
      jobBy: jobBy ?? this.jobBy,
      offerBy: offerBy ?? this.offerBy,
      offerId: offerId ?? this.offerId,
      mandateId: mandateId ?? this.mandateId,
      createdDate: createdDate ?? this.createdDate,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  // Converts a Firestore document snapshot into an instance of ConversationModel
  factory ConversationModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return ConversationModel(
      docId: doc.id,
      chatAgreement: data['chatAgreement'],
      content: data['content'],
      participants: List<String>.from(data['participants'] ?? []),
      jobId: data['jobId'],
      jobBy: data['jobBy'],
      offerBy: data['offerBy'],
      offerId: data['offerId'],
      mandateId: data['mandateId'],
      createdDate:
          data['createdDate'] is Timestamp ? data['createdDate'] : null,
      lastModified:
          data['lastModified'] is Timestamp ? data['lastModified'] : null,
    );
  }

  // Converts an instance of ConversationModel to a Map (JSON)
  Map<String, dynamic> toJson() {
    return {
      'chatAgreement': chatAgreement,
      'content': content,
      'participants': participants,
      'jobId': jobId,
      'jobBy': jobBy,
      'offerBy': offerBy,
      'offerId': offerId,
      'mandateId': mandateId,
      'createdDate': FieldValue.serverTimestamp(),
      'lastModified': FieldValue.serverTimestamp(),
    };
  }
}
