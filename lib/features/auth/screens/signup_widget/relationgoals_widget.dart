// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class RelationGoalsWidget extends StatelessWidget {
  final List<String> relationGoals;
  final TabController tabController;
  const RelationGoalsWidget({
    Key? key,
    required this.relationGoals,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WidgetTitle(
              title: "Your relationship goals 💘",
              subTitle:
                  "Choose the type of relationship you're seeking on Pesst. Love, friendship or something in between -- it's your choice."),
          mediumPaddingVert,
          //! widget choose relation goals
          RealtionSelectionScreen(
            relationGoals: relationGoals,
          ),
        ],
      ),
    );
  }
}

class RealtionSelectionScreen extends StatefulWidget {
  final List<String> relationGoals;
  const RealtionSelectionScreen({
    Key? key,
    required this.relationGoals,
  }) : super(key: key);
  @override
  _RealtionSelectionScreenState createState() =>
      _RealtionSelectionScreenState();
}

class _RealtionSelectionScreenState extends State<RealtionSelectionScreen> {
  //String selectedValue = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildSelectableContainer('Dating 👩‍❤️‍👨',
            'seeking love and meaningful connection?\nChoose dating for genune relationship'),
        buildSelectableContainer('Friendship 🙌',
            'Expand your social circle and make new friends Opt for freindship today'),
        buildSelectableContainer('Casual 😀',
            'Looking for fun and relaxed oncounters? Select casual for carefree connections.'),
        buildSelectableContainer('Serious Relationship 💍',
            'Ready for commitment and a lasting partnership? Pick serious relationship'),
        mediumPaddingVert,
      ],
    );
  }

  Widget buildSelectableContainer(String value, String subtitle) {
    bool isSelected = widget.relationGoals[0] == value;
    //bool isSelected = widget.relationGoals[0] == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          // selectedValue = value;
          widget.relationGoals[0] = value;
        });
      },
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? primaryColor : greyColor.shade300,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value, style: textStyleTextBold),
            smallPaddingVert,
            Text(
              subtitle,
              style: textStyleText,
            ),
          ],
        ),
      ),
    );
  }
}
