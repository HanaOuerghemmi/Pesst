import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/common/storage_firebase.dart';
import 'package:pesst/features/auth/screens/home_auh_screen.dart';
import 'package:pesst/features/home/screen/home_application_screen.dart';

import 'package:pesst/models/user_model.dart';

import 'package:email_validator/email_validator.dart';
import 'package:pesst/utils/request_showpop.dart';
import 'package:pesst/utils/signin_popup.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({
    required this.auth,
    required this.firestore,
  });
  Stream<UserModel?> getCurrentUserDataAsStream() {
    final streamcurrentUser = auth.currentUser;
    if (streamcurrentUser != null) {
      return firestore
          .collection('Users')
          .doc(streamcurrentUser.uid)
          .snapshots()
          .map((snapshot) {
        if (snapshot.exists) {
          return UserModel.fromMap(snapshot.data()!);
        } else {
          return null;
        }
      });
    } else {
      return  Stream.value(null);
    }
  }

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('Users').doc(auth.currentUser?.uid).get();

    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
    }
    return user;
  }

  //!reset with sending mail
  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Password reset email sent successfully");
    } catch (e) {
      print("Error sending password reset email: $e");
      showSnackBar(context, "Error sending password reset email: $e");
    }
  }
//!reset password

  Future<void> resetPasswordWithOTP(
      {required String email, required String newPassword}) async {
    try {
      FirebaseAuth.instance.currentUser?.reload();
      await auth.currentUser?.updatePassword(newPassword);
      print('Password reset successfully');
    } catch (e) {
      print('Error resetting password: $e');
    }
  }
//! update password

  Future<void> updatePassword(String userEmail, String newPassword) async {
    if (userEmail == null || userEmail.isEmpty) {
      print('Please provide the user\'s email');
      return;
    }

    if (newPassword == null || newPassword.isEmpty) {
      print('Please enter a new password');
      return;
    }

    if (!EmailValidator.validate(newPassword)) {
      print('Please enter a valid new password');
      return;
    }

    try {
      // Retrieve the user by email
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: userEmail, password: "dummyPassword");

      // Reauthenticate the user before updating the password
      AuthCredential credential = EmailAuthProvider.credential(
          email: userEmail, password: "dummyPassword");
      await userCredential.user!.reauthenticateWithCredential(credential);
      // Update the password with the new password
      await userCredential.user!.updatePassword(newPassword);
      print('Password updated successfully');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        print('Wrong password provided for reauthentication.');
      } else {
        print('Error updating password: $e');
      }
    } catch (e) {
      print('Unexpected error updating password: $e');
    }
  }

// ! this function LogIn
  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      showPopUp(
          context,
          "Login Successful!",
          "You will be directed to HomePage",
          Icons.lock_clock_outlined,
          Duration(seconds: 20));
      UserModel? userModel = await getCurrentUserData();

      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeApplicationScreen(
            userModel: userModel,
          ),
        ),
        (route) => false,
      );
    } catch (error) {
      showSnackBar(context, "email or password inccorect $error");
      print("Error signing in: $error");
      return null;
    }
  }

  void signUpWithEmailAndPassword({
    required BuildContext context,
    required ProviderRef ref,
    required String email,
    required String password,
    required List<File> imageURLs,
    required String name,
    required String gender,
    required String relationGoals,
    required int age,
    required String birthday,
    required List<dynamic> interests,
    required String country,
    required String jobTitle,
  }) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        showPopUp(
            context,
            "Register Successful!",
            "You will be directed to HomePage",
            Icons.lock_clock_outlined,
            Duration(seconds: 20));
        List<String>? urlImage = await ref
            .read(commonFirebaseStorageRepositoryProvider)
            .saveUserImageToStorage(uid: user.user!.uid, files: imageURLs);

        var userModel = UserModel(
          uid: user.user!.uid,
          name: name,
          age: age,
          birthday: birthday,
          gender: gender,
          relationGoals: relationGoals,
          imageURLs: urlImage,
          interests: interests,
          bio: "",
          jobTitle: jobTitle,
          country: country,
          lastActive: DateTime.now().toUtc(),
          scoreAccount: 0,
          noteAccount: 0,
          numberPisit: 10,
        );

        await firestore
            .collection('Users')
            .doc(user.user!.uid)
            .set(userModel.toMap());

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeApplicationScreen(
              userModel: userModel,
            ),
          ),
          (route) => false,
        );
      });
    } on FirebaseAuthException catch (error) {
      print("Error signing up: $error");
      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    await auth.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeAuthScreen(),
      ),
      (route) => false,
    );
  }

  Stream<UserModel> userData(String userId) {
    return firestore.collection('users').doc(userId).snapshots().map(
          (event) => UserModel.fromMap(
            event.data()!,
          ),
        );
  }

  // Future<void> saveUserDataToFirebase(
  //     String username, String profileImageUrl) async {
  //   try {
  //     // Reference to the user's document in Firestore
  //     DocumentReference userRef = firestore.collection('users').doc();

  //     // Data to update in the user's document
  //     Map<String, dynamic> userData = {
  //       'username': username,
  //       'profileImageUrl': profileImageUrl ?? '',
  //       // Add any other fields you want to save
  //     };

  //     // Update the user's document in Firestore
  //     await userRef.set(userData, SetOptions(merge: true));
  //   } catch (error) {
  //     print("Error saving user data: $error");
  //     // Handle the error accordingly
  //   }
  //}

  // Function to fetch user data from Firebase
  StreamController<UserModel> _userDataStreamController =
      StreamController<UserModel>.broadcast();

  Stream<UserModel> get userDataStream => _userDataStreamController.stream;

  Stream<UserModel> fetchUserData() async* {
    try {
      // Check if a user is signed in
      final User? firebaseUser = auth.currentUser;
      if (firebaseUser == null) {
        _userDataStreamController.addError('User not signed in');
        return;
      }

      // Fetch additional user data from Firestore
      final DocumentSnapshot userSnapshot =
          await firestore.collection('Users').doc(firebaseUser.uid).get();

      if (userSnapshot.exists) {
        final Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        final userModel = UserModel(
          uid: firebaseUser.uid,
          name: userData['name'] ?? '',
          age: userData['age'] ?? '',
          birthday: userData['birthday'] ?? '',
          gender: userData['gender'] ?? '',
          relationGoals: userData['relationGoals'] ?? '',
          imageURLs: List<String>.from(userData['imageURLs']),
          interests: List<String>.from(userData['interests']),
          bio: userData['bio'] ?? '',
          jobTitle: userData['jobTitle'] ?? '',
          country: userData['country'] ?? '',
          lastActive: userData['last_active'] ?? DateTime.now(),
          noteAccount: userData['noteAccount'] ?? 0,
          scoreAccount: userData['scoreAccount'] ?? 0,
          numberPisit: userData['numberPisit'] ?? 0,
        );
        _userDataStreamController.add(userModel);
        yield userModel; // Yield the user model to the stream
      } else {
        _userDataStreamController.addError('User data not found');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      _userDataStreamController.addError('Error fetching user data: $e');
    }
  }

  void dispose() {
    _userDataStreamController.close();
  }
}
