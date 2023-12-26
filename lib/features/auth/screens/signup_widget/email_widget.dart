// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/widgets/custom_validate_text_fied.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class WidgetEmail extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TabController tabController;
  final void Function(bool?)? onChanged;
  bool isChecked = false;
  WidgetEmail({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.tabController,
    required this.isChecked,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<WidgetEmail> createState() => _WidgetEmailState();
}

class _WidgetEmailState extends State<WidgetEmail> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create an account 👩‍💻",
              style: textStyleSubtitle,
            ),
            smallPaddingVert,
            Text(
              "Create your account in Seconds. We'll help you find your perfect match",
              style: textStyleText,
            ),
            smallPaddingVert,
            CustomValidateTextField(
              keyboardType: TextInputType.emailAddress,
              controller: widget.emailController,
              nameTextField: "Email",
              prefixIcon: const Icon(
                Icons.email,
                color: blackColor,
              ),
            ),

            smallPaddingVert,
            CustomValidateTextField(
              isPassword: true,
              nameTextField: "Password",
              controller: widget.passwordController,
              prefixIcon: const Icon(
                Icons.lock,
                color: blackColor,
              ),
            ),
            mediumPaddingVert,
            // ! Custom this in widget

            Row(
              children: [
                Checkbox(
                  value: widget.isChecked,
                  onChanged: widget.onChanged,
                  // (value) {
                  //   setState(() {
                  //     widget.isChecked = value!;
                  //     print(widget.isChecked);
                  //   });
                  // }
                ),
                Text(
                  'I agree to Pesst',
                  style: textStyleText.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Privacy Policy',
                    style: textStyleTextBold.copyWith(color: primaryColor),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
