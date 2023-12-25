import 'package:flutter/material.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class AppBarProfileUser extends StatelessWidget implements PreferredSizeWidget {
  const AppBarProfileUser({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //leading:
      //IconButton(
      //   onPressed: () {
      //     Navigator.pop(context);
      //   },
      //   icon: const Icon(
      //     Icons.close,
      //     size: 24,
      //   ),
      // ),

      title: Text(
        "Profile",
        style: textStyleSubtitle,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.more_vert,
            size: 24,
          ),
        ),
      ],
    );
  }
}
