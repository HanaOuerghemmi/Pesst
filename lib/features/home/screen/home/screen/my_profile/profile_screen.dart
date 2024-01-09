import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pesst/features/home/screen/home/screen/edit_profile/edit_profile.dart';
import 'package:pesst/features/home/screen/home/screen/widgets/appbar_profile.dart';
import 'package:pesst/features/home/screen/home/screen/widgets/complete_profile_widget.dart';
import 'package:pesst/features/home/screen/home/screen/widgets/image_widget.dart';
import 'package:pesst/features/home/screen/home/screen/widgets/info_user_profile.dart';
import 'package:pesst/features/home/screen/home/screen/widgets/show_list_item.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class ProfileScreen extends StatefulWidget {
  final UserModel userModel;
  const ProfileScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<bool> listBoolPictures = [
      true,
      false,
      false,
      false,
      false,
      false,
    ];
    return Scaffold(
      appBar: const AppBarProfile(),
      body: Consumer(builder: (context, ref, child) {
        for (int index = 1; index <= 5; index++) {
          if (widget.userModel.imageURLs!.length > index) {
            print(widget.userModel.imageURLs!.length);

            listBoolPictures[index] = true;
          } else {
            listBoolPictures[index] = false;
          }
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CompleteProfileWidget(),
                mediumPaddingVert,
                ImageWidget(
                  imageUrl: widget.userModel.imageURLs![0],
                ),
                smallPaddingVert,
                InfoUserWidget(
                  user: widget.userModel,
                  userid: widget.userModel.uid,
                  name: widget.userModel.name,
                  age: widget.userModel.age.toString(),
                  gender: widget.userModel.gender,
                  jobTitle: widget.userModel.jobTitle,
                  country: widget.userModel.country
                      .substring(0, widget.userModel.country.length - 5),
                ),
                smallPaddingVert,
                mediumPaddingVert,
                listBoolPictures[1] ? mediumPaddingVert : const SizedBox(),
                listBoolPictures[1]
                    ? ImageWidget(
                        imageUrl: widget.userModel.imageURLs![1],
                      )
                    : const SizedBox(),

                smallPaddingVert,
                divider,
                smallPaddingVert,
                AboutMeWidget(
                  aboutMe: widget.userModel.bio.trim() == ""
                      ? "Describe yourself in two sentences to make your profile stand out. What are your key qualities or interests that you want someone to know? "
                      : widget.userModel.bio,
                ),
                mediumPaddingVert,
                listBoolPictures[2] ? mediumPaddingVert : const SizedBox(),
                listBoolPictures[2]
                    ? ImageWidget(
                        imageUrl: widget.userModel.imageURLs![2],
                      )
                    : const SizedBox(),
                smallPaddingVert,
                divider,
                smallPaddingVert,
                SectionWidget(
                  nameSection: "Interests",
                  interests: widget.userModel.interests as List<String>,
                ),
                mediumPaddingVert,
                listBoolPictures[3] ? mediumPaddingVert : const SizedBox(),
                listBoolPictures[3]
                    ? ImageWidget(
                        imageUrl: widget.userModel.imageURLs![3],
                      )
                    : const SizedBox(),
                smallPaddingVert,
                divider,
                smallPaddingVert,
                //! section Relationship goals
                RelationshipGoalWidget(
                  title: "Relation Goals",
                  relationGoals: widget.userModel.relationGoals,
                ),
                mediumPaddingVert,
                listBoolPictures[4] ? mediumPaddingVert : const SizedBox(),
                listBoolPictures[4]
                    ? ImageWidget(
                        imageUrl: widget.userModel.imageURLs![4],
                      )
                    : const SizedBox(),
                mediumPaddingVert,
                listBoolPictures[5] ? mediumPaddingVert : const SizedBox(),
                listBoolPictures[5]
                    ? ImageWidget(
                        imageUrl: widget.userModel.imageURLs![5],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: greyColor.shade200,
        //lightColor,
        onPressed: () {
          Navigator.pushNamed(context, EditProfile.routeName, arguments: {
            'userid': widget.userModel.uid,
            'user': widget.userModel
          }).then((value) {
            setState(() {});
          });
        },
        child: SvgPicture.asset(
          "assets/svg/edit.svg",
          height: 24,
          width: 24,
          color: primaryColor,
        ),
        //FaIcon(FontAwesomeIcons.pencil, color: primaryColor),
        //Icon(Icons.edit , color: primaryColor,),
      ),
    );
  }
}

class AboutMeWidget extends StatelessWidget {
  final String aboutMe;
  const AboutMeWidget({
    Key? key,
    required this.aboutMe,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About Me",
          style: textStyleTextBold,
        ),
        smallPaddingVert,
        Text(
          aboutMe,
          style: textStyleText,
        )
      ],
    );
  }
}

class SectionWidget extends StatelessWidget {
  final String nameSection;
  final List<String> interests;
  final bool? hadtitle;
  const SectionWidget({
    Key? key,
    required this.nameSection,
    required this.interests,
    this.hadtitle = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hadtitle!
            ? Text(
                nameSection,
                style: textStyleTextBold,
              )
            : SizedBox.shrink(),
        smallPaddingVert,
        ShowListItem(
          list: interests,
        ),
      ],
    );
  }
}

class RelationshipGoalWidget extends StatelessWidget {
  final String relationGoals;
  final String? title;
  final bool? hadtile;

  const RelationshipGoalWidget({
    Key? key,
    required this.relationGoals,
    required this.title,
    this.hadtile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        hadtile == false
            ? Text(
                title!,
                style: textStyleTextBold,
              )
            : SizedBox.shrink(),
        smallPaddingVert,
        ItemList(
          text: relationGoals,
        ),
      ],
    );
  }
}
