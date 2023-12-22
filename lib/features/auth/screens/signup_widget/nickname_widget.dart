import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/widgets/customtext_field.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/helper_padding.dart';

class WidgetNickName extends StatelessWidget {
  final TabController tabController;
  final TextEditingController nameController;
  const WidgetNickName({
    super.key,
    required this.tabController,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      WidgetTitle(
          title: 'Your Pesst identy 😎',
          subTitle:
              "Create a unique nickname that represents you it's how other will know and remember you"),
      mediumPaddingVert,
      CustomTextField(
        hintText: 'Nickname',
        controller: nameController,
      )
    ]);
  }
}
