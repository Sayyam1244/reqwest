import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/chat_services.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/offer_services.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Domain/Models/conversation_model.dart';
import 'package:reqwest/SRC/Domain/Models/mandate_agreement_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class MandateAgreementServices {
  static Future createMandateAgreement({
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    try {
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('agreements').doc(docId);
      await docRef.set(data, SetOptions(merge: true));
      if (docId == null) {
        final offerRes = await OfferServices.updateOffer(
          offerId: data['offerId'],
          data: {"mandateId": docRef.id},
        );
        if (offerRes.runtimeType == String) {
          throw offerRes;
        }
        final chatRes = await ConversationService.initiateChat(
          ConversationModel(
                  participants: [
                data['clientId'],
                data['entrepreneurId'],
              ],
                  jobId: data['jobId'],
                  jobBy: data['clientId'],
                  offerBy: data['entrepreneurId'],
                  offerId: data['offerId'],
                  mandateId: docRef.id)
              .toJson(),
          senderId: FirebaseAuth.instance.currentUser?.uid,
        );

        if (chatRes.runtimeType == String) {
          throw offerRes;
        }
      }
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future getMandateAgreement({required String docId}) async {
    try {
      final usersRes = await UserServices.getAllUsers();
      if (usersRes.runtimeType == String) {
        throw usersRes;
      }

      final agreementRes = await FirebaseFirestore.instance
          .collection('agreements')
          .doc(docId)
          .get();
      log(agreementRes.toString());
      if (agreementRes.runtimeType == String) {
        throw agreementRes;
      }
      MandateAgreementModel mandateAgreementModel =
          MandateAgreementModel.fromFirestore(agreementRes);
      List<UserModel> users = (usersRes as List<UserModel>);
      UserModel clientUser = users.firstWhere(
          (element) => element.docId == mandateAgreementModel.clientId);
      UserModel entrepreneurUser = users.firstWhere(
          (element) => element.docId == mandateAgreementModel.entrepreneurId);
      mandateAgreementModel.clientUser = clientUser;
      mandateAgreementModel.entrepreneurUser = entrepreneurUser;
      //

      return mandateAgreementModel;
    } catch (e) {
      return e.toString();
    }
  }

  static Future acceptMandateAgreement({
    required String docId,
    required String jobId,
    required String offerId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('agreements')
          .doc(docId)
          .update({'status': 'accepted'});

      await FirebaseFirestore.instance.collection('jobs').doc(jobId).update({
        'finalizedCandidateId': FirebaseAuth.instance.currentUser!.uid,
        'finalizedOfferId': offerId,
        'jobStatus': 'in-progress',
        'mandateId': docId,
      });
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}
