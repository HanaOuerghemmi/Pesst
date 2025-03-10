// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/utils/message_enum.dart';



class DisplayTextImageGIF extends StatelessWidget {
  final String message;
  final MessageEnum type;
  final TextStyle? style;

  DisplayTextImageGIF({
    Key? key,
    required this.message,
    required this.type, this.style,
   
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPlaying = false;
    // final AudioPlayer audioPlayer = AudioPlayer();

    return Text(message,
        style: style ?? textStyleTextMeduimBold ,);
    //type == MessageEnum.text
    // ? Text(
    //     message,
    //     style: const TextStyle(
    //       fontSize: 16,
    //     ),
    //   )
    // : type == MessageEnum.audio
    //     ? StatefulBuilder(builder: (context, setState) {
    //         return IconButton(
    //           constraints: const BoxConstraints(
    //             minWidth: 100,
    //           ),
    //           onPressed: () async {
    //             if (isPlaying) {
    //               await audioPlayer.pause();
    //               setState(() {
    //                 isPlaying = false;
    //               });
    //             } else {
    //               await audioPlayer.play(UrlSource(message));
    //               setState(() {
    //                 isPlaying = true;
    //               });
    //             }
    //           },
    //           icon: Icon(
    //             isPlaying ? Icons.pause_circle : Icons.play_circle,
    //           ),
    //         );
    //       })
    //     : type == MessageEnum.video
    //         ? VideoPlayerItem(
    //             videoUrl: message,
    //           )
    //         : type == MessageEnum.gif
    //             ? CachedNetworkImage(
    //                 imageUrl: message,
    //               )
    //             : CachedNetworkImage(
    //                 imageUrl: message,
    //               );
  }
}
