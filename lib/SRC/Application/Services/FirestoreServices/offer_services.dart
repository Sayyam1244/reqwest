import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/jobs_services.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/user_services.dart';
import 'package:reqwest/SRC/Domain/Models/job_model.dart';
import 'package:reqwest/SRC/Domain/Models/offer_model.dart';
import 'package:reqwest/SRC/Domain/Models/user_model.dart';

class OfferServices {
  static Future createOffer({required Map<String, dynamic> data}) async {
    try {
      final checkPreviousOfferRes = await getOffersByUserId();
      if (checkPreviousOfferRes == String) {
        throw Exception(checkPreviousOfferRes);
      }
      //
      if (checkPreviousOfferRes is List<OfferModel>) {
        if (checkPreviousOfferRes.isEmpty) {
          await FirebaseFirestore.instance
              .collection('offers')
              .doc()
              .set(data, SetOptions(merge: true));
          return true;
        }
        final results = checkPreviousOfferRes
            .where((element) => element.jobId == data['jobId'])
            .toList();
        if (results.isEmpty) {
          await FirebaseFirestore.instance
              .collection('offers')
              .doc()
              .set(data, SetOptions(merge: true));
          return true;
        } else {
          //already offered
          throw Exception("You have already posted an offer against this job.");
        }
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future getOffersByUserId({String? userId}) async {
    try {
      final offersRes = await FirebaseFirestore.instance
          .collection('offers')
          .where('userId',
              isEqualTo: userId ?? FirebaseAuth.instance.currentUser!.uid)
          .get();
      return offersRes.docs.map((e) => OfferModel.fromFirestore(e)).toList();
    } catch (e) {
      return e.toString();
    }
  }

  static Stream streamOffersByUserId({required String userId}) async* {
    dynamic usersRes;
    dynamic jobsRes;
    final res = await Future.wait([
      UserServices.getAllUsers(),
      JobsServices.getJobs(),
    ]);
    usersRes = res[0];
    jobsRes = res[1];

    if (usersRes is String) {
      throw usersRes;
    }
    if (jobsRes is String) {
      throw jobsRes;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Stream<QuerySnapshot> querySnapshot = firestore
        .collection('offers')
        .where('offerTo', isEqualTo: userId)
        .where('offerStatus', isEqualTo: 'pending')
        .orderBy('createdDate', descending: true)
        .snapshots();
    await for (var snapshot in querySnapshot) {
      log(snapshot.docs.length.toString());
      try {
        List<OfferModel> offers = snapshot.docs.map((e) {
          final offerModel =
              OfferModel.fromMap(e.data() as Map<String, dynamic>);
          offerModel.docId = e.id;
          UserModel userModel = (usersRes as List<UserModel>)
              .firstWhere((element) => element.docId == offerModel.userId);
          JobModel jobModel = (jobsRes as List<JobModel>)
              .firstWhere((element) => element.docId == offerModel.jobId);
          offerModel.userModel = userModel;
          offerModel.jobModel = jobModel;
          return offerModel;
        }).toList();

        yield offers;
      } catch (e) {
        yield e;
      }
    }
  }

  static Future getOffersByJobId({required String jobId}) async {
    try {
      final offersRes = await FirebaseFirestore.instance
          .collection('offers')
          .where('jobId', isEqualTo: jobId)
          .get();
      return offersRes.docs.map((e) => OfferModel.fromFirestore(e)).toList();
    } catch (e) {
      return e.toString();
    }
  }

  static Future changeStatus(
      {required String offerId,
      required String jobId,
      required String status}) async {
    try {
      final offersListRes = await getOffersByJobId(jobId: jobId);
      if (offersListRes.runtimeType == String) {
        throw offersListRes;
      }
      final results = (offersListRes as List<OfferModel>)
          .where((element) => element.offerStatus == 'accepted');
      if (results.isNotEmpty) {
        throw 'You have already accepted an offer for this job.';
      }
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .update({"offerStatus": status});

      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future getOffer(String offerId) async {
    try {
      final offerRes = await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .get();
      return OfferModel.fromFirestore(offerRes);
    } catch (e) {
      return e.toString();
    }
  }

  static Future updateOffer(
      {required String offerId, required Map<String, String> data}) async {
    try {
      await FirebaseFirestore.instance
          .collection('offers')
          .doc(offerId)
          .set(data, SetOptions(merge: true));
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Stream streamOffersOfUser({required String userId}) async* {
    dynamic usersRes;
    dynamic jobsRes;
    final res = await Future.wait([
      UserServices.getAllUsers(),
      JobsServices.getJobs(),
    ]);
    usersRes = res[0];
    jobsRes = res[1];

    if (usersRes is String) {
      throw usersRes;
    }
    if (jobsRes is String) {
      throw jobsRes;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Stream<QuerySnapshot> querySnapshot = firestore
        .collection('offers')
        .where('userId', isEqualTo: userId)
        // .where('offerStatus', isEqualTo: 'pending')
        .orderBy('createdDate', descending: true)
        .snapshots();
    await for (var snapshot in querySnapshot) {
      log(snapshot.docs.length.toString());
      try {
        List<OfferModel> offers = snapshot.docs.map((e) {
          final offerModel =
              OfferModel.fromMap(e.data() as Map<String, dynamic>);
          offerModel.docId = e.id;
          UserModel userModel = (usersRes as List<UserModel>)
              .firstWhere((element) => element.docId == offerModel.userId);
          JobModel jobModel = (jobsRes as List<JobModel>)
              .firstWhere((element) => element.docId == offerModel.jobId);
          offerModel.userModel = userModel;
          offerModel.jobModel = jobModel;
          return offerModel;
        }).toList();

        yield offers;
      } catch (e) {
        yield e;
      }
    }
  }
}
