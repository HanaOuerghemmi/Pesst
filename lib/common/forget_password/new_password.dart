import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:pesst/features/auth/screens/login_screen.dart';
import 'package:pesst/features/auth/screens/widgets/custom_validate_text_fied.dart';
import 'package:pesst/features/auth/screens/widgets/customtext_field.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/widgets/custom_button.dart';

class NewPasswordSceen extends ConsumerStatefulWidget {
  static const routeName = '/NewPasswordSceen';
  final TextEditingController emailController;
  

  NewPasswordSceen(
      {Key? key, required this.emailController})
      : super(key: key);



  @override
  ConsumerState<NewPasswordSceen> createState() => _NewPasswordSceenState();
}

class _NewPasswordSceenState extends ConsumerState<NewPasswordSceen> {

  forgetPassword(String password) async {
    ref.read(authControllerProvider).
    //updatePassword(widget.emailController.text.trim(), password.trim());
    resetPasswordWithOTP(
     email:widget.emailController.text.trim(), 
      newPassword: password.trim());
      
  }

final passwordController = TextEditingController();
 bool showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
             const  WidgetTitle(
                title: "Create new password 🔒",
                subTitle:
                    "Create your new password if you forget it, the you have to do forget password",
              ),
              mediumPaddingVert,
              CustomValidateTextField(
                nameTextField: "Password",
                controller: passwordController,
                isPassword: true,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: blackColor,
                ),
                
              ),
              largePaddingVert,
              CustomButton(
                colorText: whiteColor,
                textButton: "Continue",
                onPressed: ()async {
                forgetPassword(passwordController.text);

                Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginScreen.routeName,
                       (route) => false,
                      );     
                },
              )
                
            ],
          ),
        ),
      ),
    );
  }
}
