import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/widgets/custom_image_container.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/helper_padding.dart';

class WidgetImages extends StatelessWidget {
  final TabController tabController;
  final List<File?> listImages;

  const WidgetImages({
    Key? key,
    required this.tabController,
    required this.listImages,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   mainAxisSize: MainAxisSize.max,
          //   children: [
          Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WidgetTitle(
              title: "Show your best self 📸",
              subTitle:
                  "Upload up to six of your best photos to make a fantastic first impression. Let your personality shine"),
          mediumPaddingVert,
          ImagesContainer(listImages: listImages),
        ],
      ),
    );
  }
}

class ImagesContainer extends StatelessWidget {
  const ImagesContainer({
    super.key,
    required this.listImages,
  });

  final List<File?> listImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 0.4,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.66,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          return (listImages.length > index)
              ? CustomImageContainer(
                  listImages: listImages,
                  imageUrl: listImages[index],
                )
              : CustomImageContainer(
                  listImages: listImages,
                );
        },
      ),
    );
  }
}
