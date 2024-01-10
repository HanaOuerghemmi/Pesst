import 'package:flutter/material.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class CompleteProfileWidget extends StatelessWidget {
  const CompleteProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      height: 140,
      child: Row(
        children: [
          CompletProgreseProfile(),
          mediumPaddingHor,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Complete Your profile",
                style: textStyleTextBold.copyWith(color: whiteColor),
              ),
              // ! to fix this text with fitBox
              Text(
                "Complete your profile to \nexperience the best dating\nexperience and better chat",
                style: textStyleText.copyWith(color: whiteColor),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CompletProgreseProfile extends StatelessWidget {
  const CompletProgreseProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          "15%",
          style: textStyleSubtitle.copyWith(color: whiteColor),
        ),
        SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(
            value: 0.1,
            color: whiteColor,
            backgroundColor: whiteColor.withOpacity(0.2),
            strokeWidth: 4,
          ),
        ),
      ],
    );
  }
}
