import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? docId;
  final String senderId;
  final String content;
  final String type;
  Timestamp? createdDate;

  // Constructor
  MessageModel({
    this.docId,
    required this.senderId,
    required this.content,
    required this.type,
    this.createdDate,
  });

  // Factory constructor to create an instance of MessageModel from Firestore DocumentSnapshot
  factory MessageModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data()!;
    return MessageModel(
      docId: snapshot.id,
      senderId: map['senderId'],
      content: map['content'],
      type: map['type'],
      createdDate: map['createdDate'],
    );
  }
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      docId: map['docId'],
      senderId: map['senderId'],
      content: map['content'],
      type: map['type'],
      createdDate: map['createdDate'],
    );
  }

  // Method to convert the MessageModel instance to a Map for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'senderId': senderId,
      'content': content,
      'type': type,
      'createdDate': FieldValue.serverTimestamp(),
    };
  }

  // Method to create a copy of the MessageModel with updated fields
  MessageModel copyWith({
    String? docId,
    String? senderId,
    String? content,
    String? type,
    Timestamp? createdDate,
  }) {
    return MessageModel(
      docId: docId ?? this.docId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
