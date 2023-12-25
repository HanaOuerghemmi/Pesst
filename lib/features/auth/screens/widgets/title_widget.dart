import 'package:flutter/material.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class WidgetTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  const WidgetTitle({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: textStyleSubtitle,
          ),
        ),
        smallPaddingVert,
        Text(
          subTitle,
          style: textStyleText,
        ),
      ],
    );
  }
}
