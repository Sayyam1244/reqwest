import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:reqwest/SRC/Application/Services/ApiServices/api_services.dart';
import 'package:reqwest/SRC/Domain/Models/job_model.dart';

class JobsServices {
  static Future createJob({required Map<String, dynamic> data}) async {
    try {
      log(data.toString());
      await FirebaseFirestore.instance
          .collection('jobs')
          .doc()
          .set(data, SetOptions(merge: true));
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future updateJobStatus(
      {required Map<String, dynamic> data, required String jobId}) async {
    try {
      await FirebaseFirestore.instance
          .collection('jobs')
          .doc(jobId)
          .update(data);
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  static Future getJob(String jobId) async {
    try {
      final jobRes =
          await FirebaseFirestore.instance.collection('jobs').doc(jobId).get();
      return JobModel.fromFirestore(jobRes);
    } catch (e) {
      return e.toString();
    }
  }

  static Future getJobs({
    String? userId,
    bool fetchOffers = false,
    String? jobStatus,
    String? location,
    String? jobTitle,
    bool? jobIsActive,
    bool? jobIsBlocked,
    bool? offerIsActive,
    bool? offerIsRejected,
  }) async {
    final Map<String, dynamic> requestBody = {
      if (userId != null) 'userId': userId,
      'fetchOffers': fetchOffers,
      if (jobStatus != null) 'jobStatus': jobStatus,
      if (location != null) 'location': location,
      if (jobTitle != null) 'jobTitle': jobTitle,
      if (jobIsActive != null) 'jobIsActive': jobIsActive,
      if (jobIsBlocked != null) 'jobIsBlocked': jobIsBlocked,
      if (offerIsActive != null) 'offerIsActive': offerIsActive,
      if (offerIsRejected != null) 'offerIsRejected': offerIsRejected,
    };

    String firebaseFunctionUrl =
        'https://us-central1-technical-taskhire.cloudfunctions.net/getJobs';

    final response = await ApiServices.instance.postApi(
      url: firebaseFunctionUrl,
      body: requestBody,
    );

    if (response['status'] == true) {
      List<dynamic> data = response['data'];
      return data.map((job) => JobModel.fromMap(job)).toList();
    } else {
      return '${response['error']}';
    }
  }

  static Future getAcceptedJobs({
    String? userId,
    String? jobStatus,
    bool? jobIsActive,
    bool? jobIsBlocked,
  }) async {
    final Map<String, dynamic> requestBody = {
      if (userId != null) 'userId': userId,
      if (jobStatus != null) 'jobStatus': jobStatus,
      if (jobIsActive != null) 'jobIsActive': jobIsActive,
      if (jobIsBlocked != null) 'jobIsBlocked': jobIsBlocked,
    };

    String firebaseFunctionUrl =
        'https://us-central1-technical-taskhire.cloudfunctions.net/acceptedJobs';

    final response = await ApiServices.instance.postApi(
      url: firebaseFunctionUrl,
      body: requestBody,
    );
    log(response.toString());
    if (response['status'] == true) {
      List<dynamic> data = response['data'];
      return data.map((job) => JobModel.fromMap(job)).toList();
    } else {
      return '${response['error']}';
    }
  }

  static Future uploadFile(File file) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('job_images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await ref.putFile(file);
      String link = await ref.getDownloadURL();

      return link;
    } catch (e) {
      return false;
    }
  }
}
