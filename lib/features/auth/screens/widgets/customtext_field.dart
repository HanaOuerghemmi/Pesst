// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  int? maxLength;
  int? maxline;
  double? fSize;
  TextInputType? keyboardType;
  FocusNode? focusNode;

  CustomTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.maxLength,
      this.keyboardType,
      this.focusNode,
      this.fSize,
      this.maxline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200], // Set the background color to grey
      ),
      child: TextField(
        controller: controller,
        maxLines: maxline ?? 1,
        maxLength: maxLength,
        keyboardType: keyboardType,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: fSize ?? 26,
            color: blackColor,
            fontWeight: FontWeight.w700),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          labelStyle: textStyleText, // Adjust content padding as needed
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: fSize ?? 26,
              color: Colors.grey[500],
              fontWeight: FontWeight.w700),
          border: InputBorder.none, // Remove the default border
          counterText: '',
        ),
      ),
    );
  }
}
