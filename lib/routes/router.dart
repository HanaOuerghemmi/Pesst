import 'package:flutter/material.dart';
import 'package:pesst/common/forget_password/new_password.dart';
import 'package:pesst/common/forget_password/otp_verification.dart';
import 'package:pesst/common/forget_password/reset_password.dart';
import 'package:pesst/features/auth/screens/login_screen.dart';
import 'package:pesst/features/home/screen/profile/user_profile.dart';
import 'package:pesst/models/user_model.dart';

import '../features/auth/screens/signup_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case resetPassword.routeName:
      return MaterialPageRoute(
        builder: (context) => const resetPassword(),
      );

    case OtpVerificationScreen.routeName:
      final argument = settings.arguments as Map<String, dynamic>;
      String email = argument['emailController'] as String;
      List<String> otp = argument['otp'] as List<String>;
      return MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          emailController: TextEditingController(text: email),
          otp: otp,
        ),
      );
    case NewPasswordSceen.routeName:
      final argument = settings.arguments as Map<String, dynamic>;
      String email = argument['emailController'] as String;

      return MaterialPageRoute(
          builder: (context) => NewPasswordSceen(
                emailController: TextEditingController(text: email),
              ));
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
    case SignUpScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      );
      
    // case UserProfile.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;

    //   return MaterialPageRoute(
    //     builder: (context) => UserProfile(
    //       userModel: arguments['userModel'] as UserModel,
    //       ownUserModel: arguments['ownUserModel'] as UserModel,
    //     ),
    //   );

    // case ChatContactScreen.routeName:
    //   final arguments = settings.arguments as Map<String, dynamic>;

    //   return MaterialPageRoute(
    //     builder: (context) => ChatContactScreen(
    //       nameContact: arguments['nameContact'] as String,
    //       idContact: arguments['idContact'] as String,
    //     ),
    //   );
// case  EditProfile.routeName:

// final arguments = settings.arguments as Map<String, dynamic>;
// return MaterialPageRoute(
//  builder: (context) => EditProfile(
 
//  userid: arguments['userid'] as String,
//  user: arguments ['user'] as UserModel,
//  )
//  );
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
            body: Container() // ErrorScreen(error: 'This page doesn\'t exist'),
            ),
      );
  }
}