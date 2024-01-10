//Packages

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String USER_COLLECTION = "Users";

final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    storage: FirebaseStorage.instance,
  ),
);

class CommonFirebaseStorageRepository {
  final FirebaseStorage storage;

  CommonFirebaseStorageRepository({
    required this.storage,
  });

  Future<List<String>?> saveUserImageToStorage(
      {required String uid, required List<File?> files}) async {
    List<String> results = [];
    try {
      for (int index = 0; index < files.length; index++) {
        File? imageFile = files[index]!;

        final Reference _ref =
            storage.ref().child('images/users/$uid/profile$index.png');
        final UploadTask _task = _ref.putFile(imageFile);
        await _task.whenComplete(() {
          print('File at index $index (${imageFile.path}) uploaded.');
        }).then((result) async {
          results.add(await result.ref.getDownloadURL());
        });
      }
      print('All files uploaded.');
      return results;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<String>?> saveUpdateUserImageToStorage(
      {required String uid, required List<File?> files}) async {
    List<String> results = [];
    try {
      for (int index = 0; index < files.length; index++) {
        print("before file +++++++++++ nottttttt founnnnnnnd");
        if (files[index] == null) {
          continue;
        } else {
          File imageFile = files[index]!;
          print("file nottttttt founnnnnnnd");
          final Reference _ref =
              storage.ref().child('images/users/$uid/profile$index.png');
          final UploadTask _task = _ref.putFile(imageFile);
          await _task.whenComplete(() {
            print('File at index $index (${imageFile.path}) uploaded.');
          }).then((result) async {
            results.add(await result.ref.getDownloadURL());
          });
        }
      }
      print('All files uploaded.');

      return results;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // Future<void> uploadImages() async {
  //   final FirebaseStorage storage = FirebaseStorage.instance;

  //   for (var imageFile in selectedImages) {
  //     final Reference storageRef = storage.ref().child('images/${imageFile.path.split('/').last}');
  //     final UploadTask uploadTask = storageRef.putFile(imageFile);

  //     await uploadTask.whenComplete(() {
  //       print('File ${imageFile.path} uploaded.');
  //     });
  //   }

  //   print('All files uploaded.');
  // }

  Future<String?> saveChatImageToStorage(
      String _chatID, String _userID, File _file) async {
    try {
      Reference _ref = storage.ref().child(
          'images/chats/$_chatID/${_userID}_${Timestamp.now().millisecondsSinceEpoch}.png');
      UploadTask _task = _ref.putFile(
        File(_file.path),
      );
      return await _task.then(
        (_result) => _result.ref.getDownloadURL(),
      );
    } catch (e) {
      print(e);
    }
    return null;
  }
}
