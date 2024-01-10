// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:pesst/features/chat/screens/widgets/bottom_chat_field.dart';
import 'package:pesst/features/chat/screens/widgets/chat_list.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class ChatContactScreen extends StatelessWidget {
  static const routeName = '/chat-contact-screen';
  final String nameContact;
  final String idContact;
  const ChatContactScreen({
    Key? key,
    required this.nameContact,
    required this.idContact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$nameContact",
          style: textStyleSubtitle,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(
              recieverUserId: idContact,
            ),
          ),
          BottomChatField(
            recieverUserId: idContact,
          ),
        ],
      ),
    );
  }
}
