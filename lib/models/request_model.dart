import 'dart:convert';

import 'package:pesst/models/user_model.dart';


// ignore_for_file: public_member_api_docs, sort_constructors_first
class RequestModel {
  final String uid;
  final String currentUserUid;
  final String recepieUserUid;
  final String imageSender;
  final String nameSender;
  final UserModel senderRequest;
  final String opener;
  final DateTime timeRequest;

  RequestModel({
    required this.uid,
    required this.currentUserUid,
    required this.recepieUserUid,
    required this.imageSender,
    required this.nameSender,
    required this.senderRequest,
    required this.opener,
    required this.timeRequest,
  });

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'uid': uid,
  //     'currentUserUid': currentUserUid,
  //     'recepieUserUid': recepieUserUid,
  //     'imageSender': imageSender,
  //     'nameSender': nameSender,
  //     'senderRequest': senderRequest,
  //     'opener': opener,
  //     'timeRequest': timeRequest.millisecondsSinceEpoch,
  //   };
  // }

  // factory RequestModel.fromMap(Map<String, dynamic> map) {
  //   return RequestModel(
  //     uid: map['uid'] as String,
  //     currentUserUid: map['currentUserUid'] as String,
  //     recepieUserUid: map['recepieUserUid'] as String,
  //     imageSender: map['imageSender'] as String,
  //     nameSender: map['nameSender'] as String,
  //     senderRequest: map['senderRequest'] as UserModel,
  //     opener: map['opener'] as String,
  //     timeRequest:
  //         DateTime.fromMillisecondsSinceEpoch(map['timeRequest'] as int),
  //   );
  // }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'currentUserUid': currentUserUid,
      'recepieUserUid': recepieUserUid,
      'imageSender': imageSender,
      'nameSender': nameSender,
      'senderRequest': senderRequest.toJson(),
      'opener': opener,
      'timeRequest': timeRequest.millisecondsSinceEpoch,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      uid: map['uid'] as String,
      currentUserUid: map['currentUserUid'] as String,
      recepieUserUid: map['recepieUserUid'] as String,
      imageSender: map['imageSender'] as String,
      nameSender: map['nameSender'] as String,
      senderRequest: UserModel.fromJson(map['senderRequest']),
      opener: map['opener'] as String,
      timeRequest:
          DateTime.fromMillisecondsSinceEpoch(map['timeRequest'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestModel.fromJson(String source) =>
      RequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}