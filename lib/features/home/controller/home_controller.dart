import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/home/repository/home_repository.dart';
import 'package:pesst/models/user_model.dart';


final allUserControllerProvider = FutureProvider.autoDispose((ref) {
  final homeController = ref.watch(homeRepositoryProvider);
  return homeController.fetchAllUser();
});

final homeControllerProvider = Provider((ref) {
  final homeRepository = ref.watch(homeRepositoryProvider);
  return HomeController(homeRepository: homeRepository, ref: ref);
});

class HomeController {
  final HomeRepository homeRepository;
  final ProviderRef ref;
  HomeController({
    required this.homeRepository,
    required this.ref,
  });

  Future<List<UserModel>?> fetchAllUser() async {
    List<UserModel>? listUser = await homeRepository.fetchAllUser();

    return listUser;
  }

  Future<bool> canSendRequest(String userId) async {
    return await homeRepository.canSendRequest(userId);
  }

  // void sendRequest({
  //   required String recieverUserId,
  //   required String message,
  //   required String currentUserId,
  // }) {
  //   homeRepository.sendRequest(
  //       recieverUserId: recieverUserId,
  //       message: message,
  //       currentUserId: currentUserId);
  // }

  Stream<List<UserModel>> getAllUsers({
    List<int>? minAndMaxAge,
    String? gender,
    List<String>? listOfGoalsRelationShip,
  }) {
    return homeRepository.getAllUsers(
      minAndMaxAge: minAndMaxAge,
      gender: gender,
      listOfGoalsRelationShip: listOfGoalsRelationShip,
    );
  }

  Stream<int> numberRequest() {
    return homeRepository.numberRequest();
  }

  // Stream<List<RequestModel>> getAllRequest() {
  //   return homeRepository.getAllRequest();
  // }
  Future<void> updateUser(
      String userid,
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
    homeRepository.updateUser(userid, name, birthday, jobTitle, country, bio,
        interests, gender, relationGoals, age, context);
  }
}