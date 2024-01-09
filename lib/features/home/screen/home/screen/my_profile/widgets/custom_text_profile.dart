import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';


class CustomProfileTextField extends StatefulWidget {
  final String nameTextField;
  final TextEditingController controller;
  final int? maxLength;
  final TextInputType? keyboardType;
  final DateTime? date;
  final double? width;
  final int? maxLines;
  bool? readonly;
  Widget? suffixIcon;
  Widget? prefixIcon;

  CustomProfileTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.prefixIcon,
    this.maxLength,
    this.keyboardType,
    required this.nameTextField,
    this.date,
    this.width,
    this.maxLines,
    this.readonly,
  }) : super(key: key);

  @override
  _CustomProfileTextFieldState createState() => _CustomProfileTextFieldState();
}

class _CustomProfileTextFieldState extends State<CustomProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? 155,
      child: TextFormField(
        readOnly: widget.readonly ?? false,
        controller: widget.controller,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines ?? 1,
        decoration: InputDecoration(
          suffixIcon: widget.prefixIcon,
          prefixIcon: widget.suffixIcon,
          filled: true,
          fillColor: Colors.grey.shade200,
          hintText: widget.controller.text.isEmpty
              ? widget.nameTextField
              : widget.controller.text,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

class CartInfoEditProfile extends StatelessWidget {
  final Widget widgetInfo;
  final String titleHeader;
  final void Function()? onPressed;
  const CartInfoEditProfile(
      {super.key,
      required this.widgetInfo,
      required this.titleHeader,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: greyColor.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(width: 0.7, color: greyColor)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        //!headerPart
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    titleHeader,
                    style: textStyleTextBold,
                  ),
                  IconButton(
                      onPressed: onPressed, icon: Icon(Icons.arrow_forward_ios))
                ],
              ),
              divider,
              widgetInfo,
              smallPaddingVert
            ]),
      ),
    );
  }
}
