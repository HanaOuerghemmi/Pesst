import 'package:flutter/material.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class CustomValidateTextField extends StatefulWidget {
  final String nameTextField;
  final TextEditingController controller;
  final int? maxLength;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final bool isPassword;
  Widget? suffixIcon;
  Widget? prefixIcon;
  final FormFieldValidator<String>? validator;

  CustomValidateTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.keyboardType,
    this.focusNode,
    this.isPassword = false,
    required this.nameTextField,
    this.validator,
  }) : super(key: key);

  @override
  _CustomValidateTextFieldState createState() =>
      _CustomValidateTextFieldState();
}

class _CustomValidateTextFieldState extends State<CustomValidateTextField> {
  //? Add email validation function
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      //showSnackBar(context, 'Please enter an email address' );
      return null;
      //'Please enter an email address';
    }
    if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(value)) {
      //showSnackBar(context, 'Please enter a valid email address' ) ;
      return null;
    }
    return null;
  }

  //? password validation function
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      //showSnackBar(context, 'Please enter a valid email address' ) ;
      return null;
      //'Please enter a valid email address';
    }
    if (value.length < 6) {
      // showSnackBar(context, 'Password must be at least 6 characters long' );
      return null;
    }
    return null;
  }

  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.nameTextField,
          style: textStyleTextBold,
        ),
        smallPaddingVert,
        TextFormField(
          controller: widget.controller,
          maxLength: widget.maxLength,
          keyboardType: widget.keyboardType,
          focusNode: widget.focusNode,
          obscureText: widget.isPassword && !isPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
            prefixIcon: widget.prefixIcon,
            filled: true,
            fillColor: Colors.grey[200],
            hintText: widget.nameTextField,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none),
          ),
          validator: widget.isPassword
              ? (controller) => _validatePassword(controller)
              : (controller) => _validateEmail(controller),
        ),
      ],
    );
  }
}
