import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/features/auth/screens/widgets/custom_validate_text_fied.dart';
import 'package:pesst/features/auth/screens/widgets/goto_signup.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/widgets/custom_button.dart';
import 'package:pesst/common/forget_password/reset_password.dart';
class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showPassword = true;

  logInWithEmailAndPassword() {
    if (_formKey.currentState!.validate()) {
         _formKey.currentState!.save();
    }
    ref.read(authControllerProvider).signInWithEmailAndPassword(
        context, emailController.text.trim(), passwordController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back 👋",
                  style: textStyleSubtitle,
                ),
                smallPaddingVert,
                Text(
                  "Please enter your email & password to sign in.",
                  style: textStyleText,
                ),
                smallPaddingVert,
                //* ussing a textfiel with validate function shoing snackbar
                CustomValidateTextField(
                    keyboardType:TextInputType.emailAddress,
                    controller: emailController,
                    nameTextField: "Email",
                    prefixIcon: const Icon(
                      Icons.email,
                      color: blackColor,
                    ),                 
                    ),
                // TextFieldAuth(
                //   controller: emailController,
                //   nameTextField: "Email",
                //   prefixIcon: const Icon(
                //     Icons.email,
                //     color: blackColor,
                //   ),
                // ),
                smallPaddingVert,
                CustomValidateTextField(
                  isPassword: true,
                    nameTextField: "Password",
                  controller: passwordController,
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: blackColor,
                  ),
                    ),
                // TextFieldAuth(
                //   nameTextField: "Password",
                //   controller: passwordController,
                //   obscureText: showPassword,
                //   prefixIcon: const Icon(
                //     Icons.lock,
                //     color: blackColor,
                //   ),
                //   suffixIcon: IconButton(
                //     icon: showPassword
                //         ? const Icon(Icons.visibility)
                //         : const Icon(Icons.visibility_off),
                //     onPressed: () {
                //       setState(() {
                //         showPassword = !showPassword;
                //       });
                //     },
                //     color: blackColor,
                //   ),
                // ),
                // ! Custom this in widget to Log In
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, resetPassword.routeName);
                      },
                      child: Text(
                        "Forget Password?",
                        style: textStyleTextBold.copyWith(color: primaryColor),
                      )),
                ),
                smallPaddingVert,
                const Divider(
                  height: 1,
                ),
                mediumPaddingVert,
                const GoToSignUp(),
                largePaddingVert,
                mediumPaddingVert,
                CustomButton(
                    colorText: whiteColor,
                    textButton: "Log in",
                    onPressed: logInWithEmailAndPassword
                    // () {
                      // if (!_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                        
                      // }
                      //logInWithEmailAndPassword;
                   // }
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
