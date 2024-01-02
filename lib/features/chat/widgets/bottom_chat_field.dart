import 'dart:io';
 import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pisiit/commun/utils/utils.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:pisiit/features/chat/controller/chat_controller.dart';
import 'package:pisiit/utils/colors.dart';
// import 'package:whatsapp_ui/common/utils/colors.dart';
// import 'package:whatsapp_ui/common/enums/message_enum.dart';
// import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';
// import 'package:whatsapp_ui/common/utils/utils.dart';
// import 'package:whatsapp_ui/features/chat/controller/chat_controller.dart';
// import 'package:whatsapp_ui/features/chat/widgets/message_reply_preview.dart';



class BottomChatField extends ConsumerStatefulWidget {
  final String recieverUserId;

  const BottomChatField({
    Key? key,
    required this.recieverUserId,
  }) : super(key: key);

  @override
  ConsumerState<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends ConsumerState<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  // FlutterSoundRecorder? _soundRecorder;
  bool isRecorderInit = false;
  bool isShowEmojiContainer = false;
  bool isRecording = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // _soundRecorder = FlutterSoundRecorder();
    //  openAudio();
  }

  // void openAudio() async {
  //   final status = await Permission.microphone.request();
  //   if (status != PermissionStatus.granted) {
  //     throw RecordingPermissionException('Mic permission not allowed!');
  //   }
  //   await _soundRecorder!.openRecorder();
  //   isRecorderInit = true;
  // }

  void sendTextMessage() async {
    if (isShowSendButton) {
      //print(widget.recieverUserId);
      ref.read(chatControllerProvider).sendTextMessage(
            context,
            _messageController.text.trim(),
            widget.recieverUserId,
          );
      setState(() {
        _messageController.text = '';
      });
    }
    // else {
    //   var tempDir = await getTemporaryDirectory();
    //   var path = '${tempDir.path}/flutter_sound.aac';
    //   if (!isRecorderInit) {
    //     return;
    //   }
    //   if (isRecording) {
    //     await _soundRecorder!.stopRecorder();
    //     sendFileMessage(File(path), MessageEnum.audio);
    //   } else {
    //     await _soundRecorder!.startRecorder(
    //       toFile: path,
    //     );
    //   }

    //   setState(() {
    //     isRecording = !isRecording;
    //   });
    // }
  }

  // void sendFileMessage(
  //   File file,
  //   MessageEnum messageEnum,
  // ) {
  //   ref.read(chatControllerProvider).sendFileMessage(
  //         context,
  //         file,
  //         widget.recieverUserId,
  //         messageEnum,
  //         widget.isGroupChat,
  //       );
  // }

  // void selectImage() async {
  //   File? image = await pickImageFromGallery(context);
  //   if (image != null) {
  //     sendFileMessage(image, MessageEnum.image);
  //   }
  // }

  // void selectVideo() async {
  //   File? video = await pickVideoFromGallery(context);
  //   if (video != null) {
  //     sendFileMessage(video, MessageEnum.video);
  //   }
  // }

   void selectGIF() async {
    
            // final gif = await Giphy.getGif(context: context, apiKey: '3eIFTBFqPL2wccMx26W7lo8ddtYxN4Y7');
            // if (gif != null) {
            //     // the user has selected a GIF, now handle it in your own way.
            //     // Example: display gif using the GiphyImageView:
            //     showDialog(
            //         context: context,
            //         builder: (context) => AlertDialog(
            //             title: Text(gif.title),
            //             content: GiphyImageView(
            //                 gif: gif,
            //             ),
            //         ),
            //     );
            // }
        
    //    ref.read(chatControllerProvider).sendGIFMessage(
    //          context,
    //          gif.url,
    //          widget.recieverUserId,
      
    //        );
    // }
   }

  void hideEmojiContainer() {
    setState(() {
      isShowEmojiContainer = false;
    });
  }

  void showEmojiContainer() {
    setState(() {
      isShowEmojiContainer = true;
    });
  }

  void showKeyboard() => focusNode.requestFocus();
  void hideKeyboard() => focusNode.unfocus();

  void toggleEmojiKeyboardContainer() {
    if (isShowEmojiContainer) {
      showKeyboard();
      hideEmojiContainer();
    } else {
      hideKeyboard();
      showEmojiContainer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
    //  _soundRecorder!.closeRecorder();
    isRecorderInit = false;
  }

  @override
  Widget build(BuildContext context) {
    //  final messageReply = ref.watch(messageReplyProvider);
    // final isShowMessageReply = messageReply != null;
    return Column(
      children: [
        //   isShowMessageReply ? const MessageReplyPreview() : const SizedBox(),
        Row(
          children: [
          
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  
                  focusNode: focusNode,
                  controller: _messageController,
                  onChanged: (val) {
                    if (val.isNotEmpty) {
                      setState(() {
                        isShowSendButton = true;
                      });
                    } else {
                      setState(() {
                        isShowSendButton = false;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: greyColor.shade200,
                    suffixIcon: IconButton(
                   
                   onPressed: selectGIF,
                     icon: const 

                      Icon(
                       Icons.gif_box_outlined,
                        color: primaryColor,
                      ),
                  ) ,
                    prefixIcon:  IconButton(
                   
                   onPressed: toggleEmojiKeyboardContainer,//select emoji,
                     icon: const 

                      Icon(
                       Icons. emoji_emotions_outlined,
                        color: primaryColor,
                      ),
                  ),
                    hintText: 'Type a message!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                  //maxLines: 2,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 8
              ),
              child: CircleAvatar(
                backgroundColor: primaryColor,
                radius: 25,
                child: GestureDetector(
                  child: 
                  FaIcon(FontAwesomeIcons.solidPaperPlane, color: whiteColor, size: 20,),
                  // Icon(
                  //       Icons.send,
                  //   color: Colors.white,
                  // ),
                  onTap: sendTextMessage,
                ),
              ),
            ),
          ],
        ),
        isShowEmojiContainer
            ? SizedBox(
                height: 310,
                child: 
                 EmojiPicker(
                  config: Config(
                    indicatorColor: primaryColor,
                    iconColorSelected: primaryColor,
                  ),
                   onEmojiSelected: ((category, emoji) {
                     setState(() {
                       _messageController.text =
                           _messageController.text + emoji.emoji;
                     });

                     if (!isShowSendButton) {
                       setState(() {
                         isShowSendButton = true;
                       });
                     }
                   }),
                 ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
