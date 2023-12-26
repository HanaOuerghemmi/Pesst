import 'package:flutter/material.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class GoToSignUp extends StatelessWidget {
  const GoToSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an  account?", style: textStyleTextBold),
        TextButton(
            onPressed: () {
              // Navigator.pushNamed(
              //   context,
              //  // SignUpScreen.routeName,
              // );
            },
            child: Text(
              "Sign up",
              style: textStyleTextBold.copyWith(color: primaryColor),
            ))
      ],
    );
  }
}
