import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pesst/features/auth/screens/login_screen.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/features/auth/screens/widgets/goto_signup.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/widgets/custom_button.dart';


class HomeAuthScreen extends StatelessWidget {
  const HomeAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100,),
              Center(
                child: Image.asset(
                  "assets/images/logo_app.png",
                  height: 150,
                  width: 150,
                ),
              ),
              // Text(
              //   'Pisit',
              //   style: textStyleTitle,
              // ),
              Text(
                "Let's dive in into your account",
                style: textStyleText,
              ),
              largePaddingVert,
              // ButtonSocialMedia(
              //   colorText: blackColor,
              //   textButton: "Continue with Google",
              //   onPressed: () {},
              // ),
              // mediumPaddingVert,
              // ButtonSocialMedia(
              //   colorText: blackColor,
              //   textButton: "Continue with Google",
              //   onPressed: () {},
              // ),
              // mediumPaddingVert,
              // ButtonSocialMedia(
              //   colorText: blackColor,
              //   textButton: "Continue with Google",
              //   onPressed: () {},
              // ),
              // mediumPaddingVert,
              // ButtonSocialMedia(
              //   colorText: blackColor,
              //   textButton: "Continue with Google",
              //   onPressed: () {},
              // ),
          
              // const Spacer(),
              largePaddingHor,
              SizedBox(height: 100,),
              CustomButton(
                colorText: lightColor,
                textButton: "Log in",
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    LoginScreen.routeName,
                  );
                },
              ),
              mediumPaddingVert,
              //! Custom this widget
              const GoToSignUp(),
            ],
          ),
        ),
      ),
    );
  }
}
