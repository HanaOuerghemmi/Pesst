import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:pesst/features/chat/repository/chat_repository.dart';
import 'package:pesst/models/chat_model.dart';
import 'package:pesst/models/message_model.dart';
import 'package:pesst/models/request_model.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/message_reply_provider.dart';


final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.watch(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;
  ChatController({
    required this.chatRepository,
    required this.ref,
  });

  void sendRequest({
    required String recieverUserId,
    required String message,
    required String currentUserId,
    required UserModel senderUserModel,
  }) {
    chatRepository.sendRequest(
      recieverUserId: recieverUserId,
      message: message,
      currentUserId: currentUserId,
      senderUserModel: senderUserModel,
    );
  }

  void cancelRequest({
    required String requestId,
    required String userId,
  }) {
    return chatRepository.cancelRequest(
      requestId: requestId,
      userId: userId,
    );
  }

  void accepteRequest(
      {required UserModel senderUserData,
      required UserModel recieverUserData,
      required RequestModel requestModel,
      String? msg}) {
    return chatRepository.accepteRequest(
        senderUserData: senderUserData,
        recieverUserData: recieverUserData,
        requestModel: requestModel,
        msg: msg);
  }

  Stream<List<MessageModel>> chatStream(String recieverUserId) {
    return chatRepository.getChatStream(recieverUserId);
  }

  Stream<List<RequestModel>> getAllRequest() {
    return chatRepository.getAllRequest();
  }

  Stream<List<ChatContactModel>> getAllChatcontact() {
    return chatRepository.getChatContacts();
  }

  void sendTextMessage(
    BuildContext context,
    String text,
    String recieverUserId,
  ) async {
    final messageReply = ref.read(messageReplyProvider);
    final senderMessage = await ref
        .watch(authControllerProvider)
        .getCurrentUserInfo(); //.whenComplete(() => null);
    ref.read(userDataProvider).whenData((value) {
      print("${value!.uid}+++++++++++++++++++++++++++++++++++++++++++++++++++");
      chatRepository.sendTextMessage(
        context: context,
        text: text,
        recieverUserId: recieverUserId,
        senderUserData: senderMessage!, //value!,
        messageReply: messageReply,
      );
    });
    print(text);
    ref.read(messageReplyProvider.state).update((state) => null);
  }


void sendGIFMessage(
  BuildContext context,
  String gifUrl,
  String recieverUserId,
  ) async {
    final messageReply = ref.read(messageReplyProvider);
    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newgifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
   
    final senderMessage = await ref
        .watch(authControllerProvider)
        .getCurrentUserInfo(); //.whenComplete(() => null);
    ref.read(userDataProvider).whenData((value) {
      print("${value!.uid}+++++++++++++++++++++++++++++++++++++++++++++++++++");
      chatRepository.sendGIFMessage(
        context: context, 
        gifUrl: newgifUrl, 
        recieverUserId: recieverUserId, 
        senderUserData: senderMessage!, 
        messageReply: messageReply);
    });
     ref.read(messageReplyProvider.state).update((state) => null);
  }
}