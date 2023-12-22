// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String uid;
  final String name;
  final String age;
  final String birthday;

  final String gender;
  final String relationGoals;
  final List<dynamic>? imageURLs;
  final List<dynamic> interests;
  final String bio;
  final String jobTitle;
  final String country;
  late DateTime lastActive;
  final int scoreAccount;
  final int noteAccount;
  final int numberPisit;
  UserModel({
    required this.uid,
    required this.name,
    required this.age,
    required this.birthday,
    required this.gender,
    required this.relationGoals,
    required this.imageURLs,
    required this.interests,
    required this.bio,
    required this.jobTitle,
    required this.country,
    required this.lastActive,
    required this.scoreAccount,
    required this.noteAccount,
    required this.numberPisit,
  });
//! this part of code need to fix

  factory UserModel.fromJSON(Map<String, dynamic> json) {
    return UserModel(
      uid: json["uid"],
      name: json["name"],
      lastActive: json["last_active"], //.toDate(),
      age: json["age"],
      birthday: json["birthday"],
      bio: json["bio"],
      gender: json["gender"],
      relationGoals: json["relationGoals"],
      interests: json["interests"],
      jobTitle: json["jobTitle"],
      country: json["country"],
      imageURLs: json["imageURLs"],
      noteAccount: json["noteAccount"],
      scoreAccount: json["scoreAccount"],
      numberPisit: json["numberPisit"],
      // List.from(json['imageURLs'] as List)
      //     .map((url) => url as String)
      //     .toList(),

      //     List<String>.from(
      //   json['imageURLs'].map((doc) => doc['url'] as String).toList().map(
      //             (x) => Map<String, dynamic>.from(x),
      //           ) ??
      //       [],
      // ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'birthday': birthday,
      'gender': gender,
      'relationGoals': relationGoals,
      'imageURLs': imageURLs,
      'interests': interests,
      'bio': bio,
      'jobTitle': jobTitle,
      'country': country,
      'lastActive': lastActive.toUtc().toIso8601String(),
      'noteAccount': noteAccount,
      'scoreAccount': scoreAccount,
      'numberPisit': numberPisit,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      birthday: map['birthday'] ?? '',
      gender: map['gender'] ?? '',
      relationGoals: map['relationGoals'] ?? '',
      imageURLs: List<String>.from(map['imageURLs']),
      interests: List<String>.from(map['interests']),
      bio: map['bio'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      country: map['country'] ?? '',
      lastActive: map['last_active'] ?? DateTime.now(),
      // DateTime.parse(map['last_active']).toLocal() ??
      //     DateTime.parse(DateTime.now().toString())
      // .toLocal(),  //.toDate(),
      noteAccount: map['noteAccount'] ?? 0,
      scoreAccount: map['scoreAccount'] ?? 0,
      numberPisit: map['numberPisit'] ?? 0,
    );
  }

  String lastDayActive() {
    return "${lastActive.month}/${lastActive.day}/${lastActive.year}";
  }

  bool wasRecentlyActive() {
    return DateTime.now().difference(lastActive).inHours < 1;
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
