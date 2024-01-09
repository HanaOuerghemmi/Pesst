import 'package:flutter/material.dart';
import 'package:pesst/features/home/screen/home/screen/widgets/image_widget.dart';
import 'package:pesst/utils/helper_padding.dart';

class VisibilityImage extends StatelessWidget {
  final bool visibility;
  final String image;
  const VisibilityImage({
    Key? key,
    required this.visibility,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        visibility ? mediumPaddingVert : const SizedBox(),
        visibility
            ? ImageWidget(
                imageUrl: image,
              )
            : const SizedBox()
      ],
    );
  }
}
