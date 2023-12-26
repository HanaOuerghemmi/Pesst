import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/home/screen/my_profile/edit_profile.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class InfoUserWidget extends ConsumerWidget {
  final String userid;
  final String name;
  final String age;
  final String gender;
  final String jobTitle;
  final String country;
  bool isProfile;
  UserModel user;
  InfoUserWidget(
      {required this.user,
      this.isProfile = true,
      required this.name,
      required this.age,
      required this.gender,
      required this.jobTitle,
      required this.country,
      required this.userid});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    //! fix this with futureBulider

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "$name ($age)",
            style: textStyleTextBold.copyWith(fontSize: 26),
          ),
        ),
        smallPaddingVert,
        gender == "Male"
            ? const ItemInfoUser(icon: Icons.male, textDescription: "Man")
            : gender == "Female"
                ? const ItemInfoUser(
                    icon: Icons.female, textDescription: "Woman")
                : const ItemInfoUser(
                    icon: Icons.transgender_sharp, textDescription: "Other"),
        smallPaddingVert,
        ItemInfoUser(icon: Icons.work, textDescription: jobTitle),
        smallPaddingVert,
        ItemInfoUser(icon: Icons.home, textDescription: country),
      ],
    );
  }
}

class ItemInfoUser extends StatelessWidget {
  final IconData icon;
  final String textDescription;
  const ItemInfoUser({
    Key? key,
    required this.icon,
    required this.textDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon),
        smallPaddingHor,
        Text(
          textDescription,
          style: textStyleTextMeduimBold,
        )
      ],
    );
  }
}
