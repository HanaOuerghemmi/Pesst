import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/models/user_model.dart';


final homeRepositoryProvider = Provider(
  (ref) => HomeRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class HomeRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  HomeRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<List<UserModel>> getAllUsers({
    List<int>? minAndMaxAge,
    String? gender,
    List<String>? listOfGoalsRelationShip,
  }) {
    if (gender == null) {
      print(gender);
      return firestore.collection("Users").snapshots().asyncMap((event) async {
        List<UserModel> users = [];
        for (var document in event.docs) {
          var userModel = UserModel.fromMap(document.data());
          if (auth.currentUser!.uid != userModel.uid) {
            users.add(userModel);
          }
        }
        return users;
      });
    } else {
      return firestore
          .collection("Users")
          .where(
            "age",
            isGreaterThan: minAndMaxAge![0],
            isLessThan: minAndMaxAge[1],
          )
          .where("gender", isEqualTo: gender)

          // .where("relationGoals", arrayContainsAny: listOfGoalsRelationShip)
          .snapshots()
          .asyncMap((event) async {
        List<UserModel> users = [];
        for (var document in event.docs) {
          var userModel = UserModel.fromMap(document.data());
          if (auth.currentUser!.uid != userModel.uid) {
            users.add(userModel);
          }
        }
        return users;
      });
    }
  }

  Future<List<UserModel>?> fetchAllUser() async {
    final QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('Users')
        .where("uid", isNotEqualTo: auth.currentUser!.uid)
        .get();

    List<UserModel>? listUsers;
    if (querySnapshot.docs != null) {
      listUsers = querySnapshot.docs
          .map((doc) => UserModel.fromMap(doc.data()))
          .toList();
    }
    return listUsers;
  }

  Stream<int> numberRequest() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection("Requests")
        .snapshots()
        .map((event) => event.size);
  }

// this new function about see button send Request in two sense....
  Future<bool> canSendRequest(String userId) async {
    DocumentSnapshot snapshot1 = await firestore
        .collection("Users")
        .doc(userId)
        .collection('Requests')
        .doc(auth.currentUser!.uid)
        .get();

    DocumentSnapshot snapshot2 = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection('Requests')
        .doc(userId)
        .get();

    DocumentSnapshot snapshot3 = await firestore
        .collection("Users")
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .doc(userId)
        .get();

    return snapshot1.exists || snapshot2.exists || snapshot3.exists;
  }

  ///! function for edit profile
  StreamController<UserModel?> _userDataController =
      StreamController<UserModel?>.broadcast();

  void _fetchUserData() async {
    var userData =
        await firestore.collection('Users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }

    _userDataController.add(user);
  }

  Future<void> updateUser(
      String userid,
      ProviderRef ref,
      // List<File?> imageURLs,
      String name,
      String birthday,
      String jobTitle,
      String country,
      String bio,
      List<dynamic> interests,
      String gender,
      String relationGoals,
      int age,
      BuildContext context) async {
    try {

      //!change this code !!!!!!!!!!!!!

      // List<String>? urlImage = await ref
      //     .read(commonFirebaseStorageRepositoryProvider)
      //     .saveUpdateUserImageToStorage(uid: userid, files: imageURLs);
      await firestore.collection('Users').doc(userid).update(

        {
          'name': name,
          'birthday': birthday,
          'gender': gender,
          'relationGoals': relationGoals,
          'interests': interests,
          'bio': bio,
          'jobTitle': jobTitle,
          'country': country,
          'age': age
        },
      );
      _fetchUserData();
      print('User information updated successfully');
    } catch (e) {
      // Handle the exception, e.g., log an error
      print('Error updating user: $e');
    }
  }
}
