import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/models/chat_model.dart';
import 'package:pesst/models/message_model.dart';
import 'package:pesst/models/request_model.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/message_enum.dart';
import 'package:pesst/utils/message_reply_provider.dart';

import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider(
  (ref) => ChatRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<List<RequestModel>> getAllRequest() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Requests')
        .snapshots()
        .asyncMap(
      (event) async {
        List<RequestModel> requests = [];
        for (var document in event.docs) {
          var requestModel = RequestModel.fromMap(document.data());

          var userData = await firestore
              .collection('Users')
              .doc(requestModel.currentUserUid)
              .get();
          var user = UserModel.fromMap(userData.data()!);
          print("heree");

          requests.add(RequestModel(
            uid: requestModel.uid,
            currentUserUid: requestModel.currentUserUid,
            recepieUserUid: requestModel.recepieUserUid,
            imageSender: user.imageURLs![0],
            nameSender: user.name,
            opener: requestModel.opener,
            //!you need to change names of variable to be more clear
            senderRequest: user,
            timeRequest: requestModel.timeRequest,
          ));
        }
        return requests;
      },
    );
  }

  void sendRequest({
    required String recieverUserId,
    required String message,
    required String currentUserId,
    required UserModel senderUserModel,
  }) {
    var timeSent = DateTime.now();
    var requestId = const Uuid().v1();

    final RequestModel request = RequestModel(
        uid: currentUserId,
        currentUserUid: currentUserId,
        recepieUserUid: recieverUserId,
        senderRequest: senderUserModel,
        imageSender: "",
        nameSender: "",
        opener: message,
        timeRequest: timeSent);

    firestore
        .collection("Users")
        .doc(recieverUserId)
        .collection("Requests")
        .doc(currentUserId)
        .set(request.toMap());
    firestore
        .collection("Users")
        .doc(currentUserId)
        .update({"numberPisit": -1});
  }

  void cancelRequest({
    required String requestId,
    required String userId,
  }) {
    firestore
        .collection("Users")
        .doc(userId)
        .collection("Requests")
        .doc(requestId)
        .delete();
  }

// rewrite this function
  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUserData,
    required MessageReply? messageReply,
  }) async {
    UserModel? recieverUserData;
    try {
      var timeSent = DateTime.now();

      await firestore.collection("Users").doc(recieverUserId).get().then((doc) {
        if (doc.exists) {
          var model = UserModel.fromMap(doc.data()!);
          recieverUserData = model;
        }
      });

      var messageId = const Uuid().v1();
      _saveDataToContactsSubcollectionForMsg(
          senderUserData: senderUserData,
          recieverUserData: recieverUserData!,
          text: text,
          timeSent: timeSent,
          recieverUserId: recieverUserId);

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: text,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        messageType: MessageEnum.text,
        messageReply: null,
        senderUsername: senderUserData.name, //recieverUserData!.name,
        recieverUserName: recieverUserData!.name,
      );
    } catch (e) {
      // showSnackBar(context: context, content: e.toString());
      print(e);
    }
  }

  void accepteRequest({
    required UserModel senderUserData,
    required UserModel recieverUserData,
    required RequestModel requestModel,
    String? msg,
  }) {
    _saveDataToContactsSubcollection(
        senderUserData: senderUserData,
        recieverUserData: recieverUserData,
        text: requestModel.opener,
        timeSent: requestModel.timeRequest,
        recieverUserId: recieverUserData.uid);

    var messageId = const Uuid().v1();

    _saveMessageToMessageSubcollection(
      senderId: senderUserData.uid,
      recieverUserId: recieverUserData.uid,
      text: requestModel.opener,
      timeSent: requestModel.timeRequest,
      messageId: messageId,
      username: senderUserData.name,
      messageType: MessageEnum.text,
      messageReply: null,
      senderUsername: recieverUserData.name,
      recieverUserName: senderUserData.name,
    );
    if (msg != null) {
      var now = DateTime.now();
      var messageRepondId = const Uuid().v1();
      _saveDataToContactsSubcollection(
          senderUserData: senderUserData,
          recieverUserData: recieverUserData,
          text: msg,
          timeSent: now,
          recieverUserId: recieverUserData.uid);

      _saveMessageToMessageSubcollection(
        senderId: recieverUserData.uid,
        recieverUserId: senderUserData.uid,
        text: msg,
        timeSent: now,
        messageId: messageRepondId,
        username: senderUserData.name,
        messageType: MessageEnum.text,
        messageReply: null,
        senderUsername: senderUserData.name,
        recieverUserName: recieverUserData.name,
      );
    }

    cancelRequest(requestId: requestModel.uid, userId: recieverUserData.uid);
  }

  void _saveDataToContactsSubcollectionForMsg({
    required UserModel senderUserData,
    required UserModel recieverUserData,
    required String text,
    required DateTime timeSent,
    required String recieverUserId,
  }) async {
// users -> reciever user id => chats -> current user id -> set data
    var recieverChatContact = ChatContactModel(
      name: senderUserData.name,
      profilePic: senderUserData.imageURLs![0],
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('Users')
        .doc(recieverUserId)
        .collection('Chats')
        .doc(auth.currentUser!.uid)
        .set(
          recieverChatContact.toMap(),
        );
    // users -> current user id  => chats -> reciever user id -> set data
    var senderChatContact = ChatContactModel(
      name: recieverUserData.name,
      profilePic: recieverUserData.imageURLs![0],
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .doc(recieverUserId)
        .set(
          senderChatContact.toMap(),
        );
  }

  //!this metode create chat model
  void _saveDataToContactsSubcollection({
    required UserModel senderUserData,
    required UserModel recieverUserData,
    required String text,
    required DateTime timeSent,
    required String recieverUserId,
  }) async {
// users -> reciever user id => chats -> current user id -> set data
    var recieverChatContact = ChatContactModel(
      name: senderUserData.name,
      profilePic: senderUserData.imageURLs![0],
      contactId: senderUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .doc(senderUserData.uid)
        .set(
          recieverChatContact.toMap(),
        );
    // users -> current user id  => chats -> reciever user id -> set data
    var senderChatContact = ChatContactModel(
      name: recieverUserData.name,
      profilePic: recieverUserData.imageURLs![0],
      contactId: recieverUserData.uid,
      timeSent: timeSent,
      lastMessage: text,
    );
    await firestore
        .collection('Users')
        .doc(senderUserData.uid)
        .collection('Chats')
        .doc(auth.currentUser!.uid)
        .set(
          senderChatContact.toMap(),
        );
  }

  void _saveMessageToMessageSubcollection({
    String? senderId,
    required String recieverUserId,
    required String text,
    required DateTime timeSent,
    required String messageId,
    required String username,
    required MessageEnum messageType,
    required MessageReply? messageReply,
    required String senderUsername,
    required String? recieverUserName,
  }) async {
    final message = MessageModel(
      senderId: senderId ?? auth.currentUser!.uid,
      recieverid: recieverUserId,
      text: text,
      type: messageType,
      timeSent: timeSent,
      messageId: messageId,
      isSeen: false,
      repliedMessage: messageReply == null ? '' : messageReply.message,
      repliedTo: messageReply == null
          ? ''
          : messageReply.isMe
              ? senderUsername
              : recieverUserName ?? '',
      repliedMessageType:
          messageReply == null ? MessageEnum.text : messageReply.messageEnum,
    );

    // users -> sender id -> reciever id -> messages -> message id -> store message
    await firestore
        .collection('Users')
        .doc(senderId ?? auth.currentUser!.uid)
        .collection('Chats')
        .doc(recieverUserId)
        .collection('Messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
    // users -> eciever id  -> sender id -> messages -> message id -> store message
    await firestore
        .collection('Users')
        .doc(recieverUserId)
        .collection('Chats')
        .doc(senderId ?? auth.currentUser!.uid)
        .collection('Messages')
        .doc(messageId)
        .set(
          message.toMap(),
        );
  }

  Stream<List<ChatContactModel>> getChatContacts() {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .snapshots()
        .asyncMap((event) async {
      List<ChatContactModel> contacts = [];
      for (var document in event.docs) {
        var chatContact = ChatContactModel.fromMap(document.data());
        var userData = await firestore
            .collection('Users')
            .doc(chatContact.contactId)
            .get();
        var user = UserModel.fromMap(userData.data()!);

        contacts.add(
          ChatContactModel(
            name: user.name,
            profilePic: user.imageURLs![0],
            contactId: chatContact.contactId,
            timeSent: chatContact.timeSent,
            lastMessage: chatContact.lastMessage,
          ),
        );
      }
      return contacts;
    });
  }

  Stream<List<MessageModel>> getChatStream(String recieverUserId) {
    return firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .collection('Chats')
        .doc(recieverUserId)
        .collection('Messages')
        .orderBy('timeSent')
        .snapshots()
        .map((event) {
      List<MessageModel> messages = [];
      for (var document in event.docs) {
        messages.add(MessageModel.fromMap(document.data()));
      }
      return messages;
    });
  }
   void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String recieverUserId,
    required UserModel senderUserData,
    required MessageReply? messageReply,
  }) async {
    UserModel? recieverUserData;
    try {
      var timeSent = DateTime.now();

      await firestore.collection("Users").doc(recieverUserId).get().then((doc) {
        if (doc.exists) {
          var model = UserModel.fromMap(doc.data()!);
          recieverUserData = model;
        }
      });
      var messageId = const Uuid().v1();
      _saveDataToContactsSubcollectionForMsg(
          senderUserData: senderUserData,
          recieverUserData: recieverUserData!,
          text: "GIF",
          timeSent: timeSent,
          recieverUserId: recieverUserId);

      _saveMessageToMessageSubcollection(
        recieverUserId: recieverUserId,
        text: gifUrl,
        timeSent: timeSent,
        messageId: messageId,
        username: senderUserData.name,
        messageType: MessageEnum.gif,
        messageReply: null,
        senderUsername: senderUserData.name, //recieverUserData!.name,
        recieverUserName: recieverUserData!.name,
      );
  
  
    } catch (e) {
      print(e.toString());
    
    }
  }
  
  
}