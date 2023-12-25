import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class InterestWidget extends StatefulWidget {
  final TabController tabController;
  final List<String> interests;
  const InterestWidget({
    super.key,
    required this.tabController,
    required this.interests,
  });

  @override
  State<InterestWidget> createState() => _InterestWidgetState();
}

class _InterestWidgetState extends State<InterestWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          WidgetTitle(
              title: "Discover like-minded people 🤗",
              subTitle:
                  "Share your interests passions ans hobbies We'll connect you with people who share your enthusiasm"),
          mediumPaddingVert,
          InterstList(interests: widget.interests),
        ],
      ),
    );
  }
}

class InterstList extends StatelessWidget {
  final List<String> interests;
  const InterstList({
    super.key,
    required this.interests,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runSpacing: 10,
      spacing: 5,
      children: [
        CustomTextContainer(listInteresrt: interests, text: "Travel 🛩️"),
        CustomTextContainer(listInteresrt: interests, text: "Cooking 🍳"),
        CustomTextContainer(listInteresrt: interests, text: "Photography 📸"),
        CustomTextContainer(listInteresrt: interests, text: "Hiking 🧗‍♀️"),
        CustomTextContainer(listInteresrt: interests, text: "Music 🎶"),
        CustomTextContainer(listInteresrt: interests, text: "Yoga 🧘‍♂️"),
        CustomTextContainer(listInteresrt: interests, text: "Pets 😺"),
        CustomTextContainer(listInteresrt: interests, text: "Gaming 🎮"),
        CustomTextContainer(listInteresrt: interests, text: "Painting 🖼️"),
        CustomTextContainer(listInteresrt: interests, text: "Movies 🎬"),
        CustomTextContainer(listInteresrt: interests, text: "Art 🎨"),
        CustomTextContainer(listInteresrt: interests, text: "Reading 📖"),
        CustomTextContainer(listInteresrt: interests, text: "Dancing 💃"),
        CustomTextContainer(listInteresrt: interests, text: "Sports ⚽"),
        CustomTextContainer(listInteresrt: interests, text: "Techhnology 📱"),
        CustomTextContainer(listInteresrt: interests, text: "Fashion 👗"),
        CustomTextContainer(listInteresrt: interests, text: "Motorcycling 🏍️"),
      ],
    );
  }
}

class CustomTextContainer extends StatefulWidget {
  final List<String> listInteresrt;
  final String text;

  CustomTextContainer({
    Key? key,
    required this.listInteresrt,
    required this.text,
  }) : super(key: key);

  @override
  State<CustomTextContainer> createState() => _CustomTextContainerState();
}

class _CustomTextContainerState extends State<CustomTextContainer> {
  // bool clickable = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.listInteresrt.contains(widget.text)) {
            widget.listInteresrt.remove(widget.text);
            print(widget.listInteresrt);
          } else {
            if (!widget.listInteresrt.contains(widget.text)) {
              widget.listInteresrt.add(widget.text);
              print(widget.listInteresrt);
            }
          }
        });
      },
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: widget.listInteresrt.contains(widget.text)
              ? primaryColor
              : whiteColor,
          border: Border.all(
            color: lightColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.text,
          style: textStyleTextBold.copyWith(
            color: widget.listInteresrt.contains(widget.text)
                ? whiteColor
                : blackColor,
          ),
        ),
      ),
    );
  }
}
