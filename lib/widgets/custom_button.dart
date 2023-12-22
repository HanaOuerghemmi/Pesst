// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pesst/colors.dart';
import 'package:pesst/helper_textstyle.dart';



class CustomButton extends StatelessWidget {
  final Color? colorText;
  final String textButton;
  Color? color;

  final void Function()? onPressed;
  CustomButton({
    Key? key,
    required this.colorText,
    required this.textButton,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 48.0)),
          backgroundColor: MaterialStateProperty.all(color ?? primaryColor),
        ),
        child: Text(
          textButton,
          style: textStyleTextBold.copyWith(color: colorText ?? lightColor ),
        ),
      ),
    );
  }
}
