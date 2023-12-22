import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pisiit/features/auth/repository/auth_repository.dart';
import 'package:pisiit/models/user_model.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository, ref: ref);
});

final userDataAuthProvider = FutureProvider.autoDispose((ref) {
  final authController = ref.watch(authRepositoryProvider);
  return authController.getCurrentUserData();
});

final userDataProvider = FutureProvider.autoDispose((ref) {
  final authController = ref.watch(authRepositoryProvider);
  return authController.fetchUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getCurrentUserInfo() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    authRepository.signInWithEmailAndPassword(
      context,
      email,
      password,
    );
  }

//! reset password
  Future<void> resetPasswordWithOTP(
      {required String email, required String newPassword}) async {
    await authRepository.resetPasswordWithOTP(
        email: email, newPassword: newPassword);
  }

  ///! reset
  Future<void> updatePassword(String userEmail, String newPassword) async {
    await authRepository.updatePassword(userEmail, newPassword);
  }
//!signup

  void signUpWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
    required List<File> imageURLs,
    required String name,
    required String gender,
    required String relationGoals,
    required String age,
    required String birthday,
    required List<dynamic> interests,
    required String country,
    required String jobTitle,
  }) async {
    return authRepository.signUpWithEmailAndPassword(
        context: context,
        ref: ref,
        email: email,
        password: password,
        imageURLs: imageURLs,
        name: name,
        gender: gender,
        relationGoals: relationGoals,
        age: age,
        birthday: birthday,
        interests: interests,
        country: country,
        jobTitle: jobTitle);
  }

  void signOut(BuildContext context) async {
    await authRepository.signOut(context);
  }

  // Future<void> saveUserDataToFirebase(
  //     String username, String profileImageUrl) async {
  //   authRepository.saveUserDataToFirebase(username, profileImageUrl);
  // }

  Stream<UserModel> userDataById(String userId) {
    return authRepository.userData(userId);
  }

  Future<UserModel?> fetchUserData() {
    return authRepository.fetchUserData();
  }
}
