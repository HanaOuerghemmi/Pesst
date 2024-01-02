import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';


void showPopUp(BuildContext context, String title, String message,
    IconData icon, Duration duration) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Container(
          height: 500,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: const BoxDecoration(
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/bgicons.png",
                      ),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 40,
                    color: whiteColor,
                  ),
                ),
                mediumPaddingHor,
                Text(
                  title,
                  style: textStyleSubtitle.copyWith(color: primaryColor),
                  textAlign: TextAlign.center,
                ),
                smallPaddingVert,
                Text(
                  "Please Wait",
                  style: textStyleText,
                ),
                smallPaddingVert,
                Text(
                  message,
                  style: textStyleText,
                  textAlign: TextAlign.center,
                ),
                mediumPaddingVert,
                const CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  color: lightColor,
                  strokeWidth: 6,
                )
              ]),
        ),
      );
    },
  );

  // Automatically close the dialog after the specified duration
  Future.delayed(duration, () {
    Navigator.of(context).pop();
  });
}

///!

Future<void> showSignInPopup(
    BuildContext context, String Title, String subtitle, IconData icon) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          height: 400,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 150,
                  decoration: const BoxDecoration(
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/bgicons.png",
                      ),
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 60,
                    color: whiteColor,
                  ),
                ),
                mediumPaddingHor,
                Text(
                  Title,
                  style: textStyleSubtitle.copyWith(color: primaryColor),
                  textAlign: TextAlign.center,
                ),
                smallPaddingVert,
                Text(
                  "Please Wait",
                  style: textStyleText,
                ),
                smallPaddingVert,
                Text(
                  subtitle,
                  style: textStyleText,
                  textAlign: TextAlign.center,
                ),
                mediumPaddingVert,
                const CircularProgressIndicator(
                  backgroundColor: primaryColor,
                  color: lightColor,
                  strokeWidth: 6,
                )
              ]),
        ),

        // actions: [
        //   TextButton(
        //     child: const Text('close'),
        //     onPressed: () {
        //       Navigator.of(context).pop();
        //     },
        //   ),
        // ],
      );
    },
  );
}
