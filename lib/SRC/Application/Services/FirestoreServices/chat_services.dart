import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:reqwest/SRC/Domain/Models/conversation_model.dart';
import 'package:reqwest/SRC/Domain/Models/job_model.dart';
import 'package:reqwest/SRC/Domain/Models/mandate_agreement_model.dart';
import 'package:reqwest/SRC/Domain/Models/message_model.dart';
import 'package:reqwest/SRC/Domain/Models/offer_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class ConversationService {
  // static Stream getConversations({required String userId}) async* {
  // try {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final res = await Future.wait([
  //     firestore.collection('users').get(),
  //     firestore.collection('offers').get(),
  //     firestore.collection('agreements').get(),
  //     firestore.collection('jobs').get(),
  //   ]);
  //   List<UserModel> users = res[0].docs.map((e) {
  //     return UserModel.fromFirestore(e);
  //   }).toList();
  //   List<OfferModel> offers = res[1].docs.map((e) {
  //     return OfferModel.fromFirestore(e);
  //   }).toList();
  //   List<MandateAgreementModel> agreements = res[2].docs.map((e) {
  //     return MandateAgreementModel.fromFirestore(e);
  //   }).toList();
  //   List<JobModel> jobs = res[3].docs.map((e) {
  //     return JobModel.fromFirestore(e);
  //   }).toList();
  // log('Users: ${users.length}');
  // log('Offers: ${offers.length}');
  // log('Agreements: ${agreements.length}');
  // log('Jobs: ${jobs.length}');
  //   //
  //   Stream<QuerySnapshot> querySnapshot = firestore
  //       .collection('chats')
  //       .where('participants', arrayContains: userId)
  //       .orderBy('lastModified', descending: true)
  //       .snapshots();

  //   await for (var snapshot in querySnapshot) {
  //     List<ConversationModel> conversations = snapshot.docs.map((doc) {
  //       log(doc.data().toString());
  //       ConversationModel conversationModel =
  //           ConversationModel.fromFirestore(doc);
  //       conversationModel.jobByUser = users
  //           .where((element) => element.docId == conversationModel.jobBy)
  //           .firstOrNull;
  //       conversationModel.offerByUser = users
  //           .where((element) => element.docId == conversationModel.offerBy)
  //           .firstOrNull;
  //       conversationModel.jobModel = jobs
  //           .where((element) => element.docId == conversationModel.jobId)
  //           .firstOrNull;
  //       conversationModel.offerModel = offers.where((element) {
  //         return element.docId == conversationModel.offerId;
  //       }).firstOrNull;

  //       conversationModel.mandateAgreementModel = agreements
  //           .where((element) => element.docId == conversationModel.mandateId)
  //           .firstOrNull;
  //       return conversationModel;
  //     }).toList();

  //     yield conversations;
  //   }
  //   // } catch (e) {
  //   //   yield e.toString();
  //   // }
  // }

  static final firestore = FirebaseFirestore.instance;
// Stream for real-time updates for users
  static Stream<List<UserModel>> getUsersStream() {
    return firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserModel.fromFirestore(doc)).toList();
    });
  }

// Stream for real-time updates for offers
  static Stream<List<OfferModel>> getOffersStream() {
    return firestore.collection('offers').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => OfferModel.fromFirestore(doc)).toList();
    });
  }

// Stream for real-time updates for agreements
  static Stream<List<MandateAgreementModel>> getAgreementsStream() {
    return firestore.collection('agreements').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MandateAgreementModel.fromFirestore(doc))
          .toList();
    });
  }

// Stream for real-time updates for jobs
  static Stream<List<JobModel>> getJobsStream() {
    return firestore.collection('jobs').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => JobModel.fromFirestore(doc)).toList();
    });
  }

  static Stream getConversations({required String userId}) async* {
    // Subscribe to all the required data streams
    Stream<List<UserModel>> usersStream = getUsersStream();
    Stream<List<OfferModel>> offersStream = getOffersStream();
    Stream<List<MandateAgreementModel>> agreementsStream =
        getAgreementsStream();
    Stream<List<JobModel>> jobsStream = getJobsStream();

    // Combine all the streams
    await for (var snapshot in firestore
        .collection('chats')
        .where('participants', arrayContains: userId)
        .orderBy('lastModified', descending: true)
        .snapshots()) {
      List<UserModel> users = await usersStream.first;
      List<OfferModel> offers = await offersStream.first;
      List<MandateAgreementModel> agreements = await agreementsStream.first;
      List<JobModel> jobs = await jobsStream.first;

      List<ConversationModel> conversations = snapshot.docs.map((doc) {
        ConversationModel conversationModel =
            ConversationModel.fromFirestore(doc);

        // Match related data dynamically
        conversationModel.jobByUser = users
            .where(
              (element) => element.docId == conversationModel.jobBy,
            )
            .firstOrNull;
        conversationModel.offerByUser = users
            .where(
              (element) => element.docId == conversationModel.offerBy,
            )
            .firstOrNull;
        conversationModel.jobModel = jobs
            .where(
              (element) => element.docId == conversationModel.jobId,
            )
            .firstOrNull;
        conversationModel.offerModel = offers
            .where(
              (element) => element.docId == conversationModel.offerId,
            )
            .firstOrNull;
        conversationModel.mandateAgreementModel = agreements
            .where(
              (element) => element.docId == conversationModel.mandateId,
            )
            .firstOrNull;

        return conversationModel;
      }).toList();

      yield conversations;
    }
  }

  static Future initiateChat(
    Map<String, dynamic> data, {
    String? initMessage,
    String? senderId,
  }) async {
    try {
      List listOfUsers = [data['jobBy'].hashCode, data['offerBy'].hashCode];

      listOfUsers.sort();
      final docId = "${listOfUsers[0]}__${listOfUsers[1]}__${data['jobId']}";
      await FirebaseFirestore.instance.collection("chats").doc(docId).set(data);
      sendMessage(
          data: MessageModel(
            senderId: senderId!,
            content: initMessage ?? "Chat Initiated",
            type: 'text',
          ).toJson(),
          chatId: docId);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future sendMessage({
    required Map<String, dynamic> data,
    required String chatId,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(chatId)
          .collection('messages')
          .doc()
          .set(data);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future acceptChatAgreement(String chatId) async {
    try {
      await FirebaseFirestore.instance
          .collection("chats")
          .doc(chatId)
          .set({'chatAgreement': 'accepted'}, SetOptions(merge: true));

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Stream streamChatbyId({required String chatId}) async* {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    //
    Stream<QuerySnapshot> querySnapshot = firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdDate', descending: true)
        .snapshots();

    await for (var snapshot in querySnapshot) {
      try {
        List<MessageModel> messages = snapshot.docs.map((doc) {
          MessageModel message =
              MessageModel.fromMap(doc.data() as Map<String, dynamic>);
          message.docId = doc.id;
          return message;
        }).toList();

        yield messages;
      } catch (e) {
        yield e.toString();
      }
    }
  }
}
