import 'package:flutter/material.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class AppBarProfile extends StatelessWidget implements PreferredSizeWidget {
  const AppBarProfile({super.key});

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.symmetric(
          // horizontal: 16.0,
          vertical: 16.0,
        ),
        child: Image.asset(
          "assets/images/logo.png",
          height: 30,
          width: 30,
        ),
      ),
      title: Text(
        "Profile",
        style: textStyleSubtitle,
      ),
      centerTitle: true,
      actions: [
        // GestureDetector(
        //   onTap: () {},
        //   child: UpgradeWidget(),
        // ),
        IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return CustomBottomSheet();
                },
              );
            },
            icon: const FaIcon(
              FontAwesomeIcons.rightFromBracket,
              color: primaryColor,
              size: 30,
            )

            //  Icon(
            //   Icons.logout,
            //   color: primaryColor,
            //   size: 24,
            // ),
            ),
      ],
    );
  }
}

class UpgradeWidget extends StatelessWidget {
  const UpgradeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(12),
            right: Radius.circular(12),
          )),
      child: Text(
        "⭐UPGRADE",
        style: textStyleTextMeduimBold.copyWith(color: Colors.white),
      ),
    );
  }
}
