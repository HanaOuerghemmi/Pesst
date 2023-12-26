import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imageUrl;
  double? height;
  double? width;
  ImageWidget({
    Key? key,
    required this.imageUrl,
    this.height = 400,
    this.width = 400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Image.network(
        imageUrl,
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
