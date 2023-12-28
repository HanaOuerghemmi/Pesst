import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/widgets/custom_button.dart';

class CustomBottomSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Logout',
            style: textStyleSubtitle.copyWith(color: primaryColor),
          ),
          largePaddingVert,
          Text("Are you sure you want to log out ?", style: textStyleTextBold),
          mediumPaddingVert,
          (Row(
            children: [
              Expanded(
                  child: CustomButton(
                colorText: primaryColor,
                textButton: "cancel",
                color: lightColor,
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
              Expanded(
                  child: CustomButton(
                colorText: whiteColor,
                textButton: "Yes,Logout?",
                onPressed: () {
                  ref.read(authControllerProvider).signOut(context);
                },
              )),
            ],
          )),
          mediumPaddingVert,
        ],
      ),
    );
  }
}
