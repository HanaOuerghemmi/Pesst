import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/features/chat/controller/chat_controller.dart';
import 'package:pesst/features/home/screen/home/screen/user_profile/user_profile.dart';

import 'package:pesst/models/request_model.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/widgets/custom_button.dart';


//! pop up send request
void simplePisitDialog(
    {required BuildContext context,
    required UserModel sender,
    required UserModel recipient}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // final DatabaseService databaseService = DatabaseService();
      TextEditingController controller = TextEditingController();

      return AlertDialog(
        backgroundColor: greyColor.shade200,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avaatar(urlPic: sender.imageURLs![0]),
                // ClipRRect(
                //   borderRadius: const BorderRadius.all(Radius.circular(70)),
                //   child: Image.network(
                //     sender.imageURLs![0],
                //     height: 60,
                //     width: 60,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                smallPaddingVert,
                Text(
                           sender.name.length > 8
                              ?  sender.name.substring(0, 7) +
                                  "..."  
                              :  sender.name ,style: textStyleTextBold,
                        ),
              ],
            ),

            //! here animation replace image
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),

            // Expanded(
            //   child: Lottie.network(
            //     'https://lottie.host/3c4a994a-742d-4813-99b2-978feb9425eb/XyfXscPj7u.json',
            //     //'assets/animation/animation.json',
            //     width: 200,
            //     height: 100,

            //     fit: BoxFit.fill,
            //   ),
            // ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avaatar(
                  urlPic: recipient.imageURLs![0],
                ),
                // ClipRRect(
                //   borderRadius: const BorderRadius.all(Radius.circular(70)),
                //   child: Image.network(
                //     recipient.imageURLs![0],
                //     height: 60,
                //     width: 60,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                smallPaddingVert,
                Text(
                           recipient.name.length > 8
                              ?  recipient.name.substring(0, 7) +
                                  "..."  
                              :  recipient.name ,style: textStyleTextBold,
                        ),
                // Text(
                //   recipient.name,
                //   style: textStyleTextBold,
                // )
              ],
            ),
          ],
        ),
        content: CustomTextField(
          hintText: "your Opener ..... be Creative.......",
          obscureText: false,
          controller: controller,
          maxLines: 4,
          style: textStyleTextBold.copyWith(
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer(builder: (context, ref, child) {
              return CustomButton(
                colorText: whiteColor,
                textButton: "send",
                onPressed: () async {
                  ref.watch(chatControllerProvider).sendRequest(
                        recieverUserId: recipient.uid,
                        message: controller.text,
                        currentUserId: sender.uid,
                        senderUserModel: sender,
                      );
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              );
            }),
          ),
        ],
      );
    },
  );
}

//! pop up repondre about request
void popUpRepondRequestDialog(
    {required BuildContext context,
    required RequestModel requestModel,
    required UserModel recipient,
    required UserModel sender}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController controller = TextEditingController();
      return AlertDialog(
        backgroundColor: greyColor.shade200,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        UserProfile.routeName,
                        arguments: {
                          "userModel": sender,
                          "ownUserModel": recipient
                        },
                      );
                    },
                    child: Avaatar(urlPic: requestModel.imageSender)),
                // ClipRRect(
                //   borderRadius: const BorderRadius.all(Radius.circular(12)),
                //   child: Image.network(
                //     requestModel.imageSender,
                //     height: 80,
                //     width: 80,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                smallPaddingVert,
                 Text(
                           requestModel.nameSender.length > 8
                              ?  requestModel.nameSender.substring(0, 7) +
                                  "..."  
                              :  requestModel.nameSender ,style: textStyleTextBold,
                        ),
                // Text(
                //   requestModel.nameSender,
                //   style: textStyleTextBold,
                // )
              ],
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Avaatar(urlPic: recipient.imageURLs![0]),
                // ClipRRect(
                //   borderRadius: const BorderRadius.all(Radius.circular(12)),
                //   child: Image.network(
                //     recipient.imageURLs![0],
                //     height: 80,
                //     width: 80,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                smallPaddingVert,
                 SubstringName(name: recipient.name,),
                // Text(
                //   recipient.name,
                //   style: textStyleTextBold,
                // )
              ],
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // smallPaddingVert,
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     "${requestModel.nameSender} :",
              //     style: textStyleTextBold,
              //   ),
              // ),
              smallPaddingVert,
              SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: lightColor, // Adjust the color of the box as needed
                  ),
                  width: double.maxFinite,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      requestModel.opener,
                      style: textStyleTextBold.copyWith(
                                               fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              smallPaddingVert,
              CustomTextField(
                hintText: "Repond about your Request...",
                obscureText: false,
                controller: controller,
                maxLines: 2,
                style: textStyleTextBold.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w300
                ),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Consumer(
            builder: (context, ref, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // You can set your desired color here
                      border: Border.all(
                        color: primaryColor,
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          // ! here
                          ref.watch(chatControllerProvider).cancelRequest(
                              requestId: requestModel.uid,
                              userId: recipient.uid);
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: 30,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.text.isEmpty) {
                        ref.watch(chatControllerProvider).accepteRequest(
                              senderUserData: sender,
                              recieverUserData: recipient,
                              requestModel: requestModel,
                            );
                      } else {
                        ref.watch(chatControllerProvider).accepteRequest(
                            senderUserData: sender,
                            recieverUserData: recipient,
                            requestModel: requestModel,
                            msg: controller.text);
                      }

                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // You can set your desired color here
                        border: Border.all(
                          color: primaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                          child: Image.asset(
                        "assets/images/logo.png",
                        height: 30,
                      )),
                    ),
                  ),
                ],
              );
            },
          )

          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Consumer(builder: (context, ref, child) {
          //     return CustomButton(
          //       colorText: purpleColor,
          //       textButton: "send",
          //       onPressed: () async {
          //         ref.watch(homeControllerProvider).sendRequest(
          //             recieverUserId: recipient.uid,
          //             message: controller.text,
          //             currentUserId: sender.uid);

          //         Navigator.pop(context);
          //       },
          //     );
          //   }),
          // ),
        ],
      );
    },
  );
}

class SubstringName extends StatelessWidget {
  final String name;
  final TextStyle? style;
  const SubstringName({
    super.key, required this.name, this.style, 
  });

  @override
  Widget build(BuildContext context) {
    return Text(
              name.length > 8
                 ?  name.substring(0, 7) +
                     "..."  
                 :  name ,style: style ?? textStyleTextBold,
           );
  }
}

Future<void> showPopRequest(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SizedBox(
          height: 400,
          width: double.infinity,
          child: Column(children: [
            Row(
              children: [],
            ),
            Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/bgicon.png"),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 60,
                  color: Colors.white,
                ),
              ),
            ),
            WidgetTitle(title: "welcome", subTitle: "please wait"),
            mediumPaddingVert,
            CircularProgressIndicator(
              strokeWidth: 4,
            )
          ]),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

int calculateAge(String birthday) {
  // Parse the birthday string into a DateTime object
  List<String> parts = birthday.split('/');
  int day = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int year = int.parse(parts[2]);
  DateTime birthDate = DateTime(year, month, day);

  // Calculate the difference between the current date and the birthdate
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;

  // Check if the birthday has occurred this year
  if (currentDate.month < birthDate.month ||
      (currentDate.month == birthDate.month &&
          currentDate.day < birthDate.day)) {
    age--;
  }

  return age;
}

class CustomTextField extends StatelessWidget {
  Function(String)? onEditingComplete;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  IconData? icon;
  int? maxLines;
  TextStyle? style;

  CustomTextField(
      {this.onEditingComplete,
      required this.hintText,
      required this.obscureText,
      required this.controller,
      this.icon,
      this.maxLines,
      this.style});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        //margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: blackColor.withOpacity(0.4),
              //offset: Offset(0, 4),
              blurRadius: 4,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: lightColor.withOpacity(0.5),
              // offset: Offset(0, -1),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),

        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          onEditingComplete: () => onEditingComplete!(controller.value.text),
          maxLines: maxLines,
          style: style ?? TextStyle(color: primaryColor),
          obscureText: obscureText,
          decoration: InputDecoration(
            fillColor: whiteColor.withOpacity(0.8),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: primaryColor,
            ),

            //prefixIcon: Icon(icon, color: Colors.white54),
          ),
        ),
      ),
    );
  }
}

///! snack bar
void showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    backgroundColor: primaryColor,
    content: Text(
      text,
      style: textStyleTextBold.copyWith(color: whiteColor),
      textAlign: TextAlign.center,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

// avatar
class Avaatar extends StatelessWidget {
  final String urlPic;
  const Avaatar({super.key, required this.urlPic});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: lightColor, // Border color
            width: 2, // Border width
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(70),
          child: CachedNetworkImage(
            imageUrl: urlPic,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ));
  }
}
