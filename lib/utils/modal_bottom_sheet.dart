import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/signup_widget/interest_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/widgets/custom_button.dart';

class ModalBottomSheet extends StatefulWidget {
  List<String> goalRelation;
  List<String> gender;
  List<int> minAndMaxAge;
  ModalBottomSheet({
    Key? key,
    required this.goalRelation,
    required this.gender,
    required this.minAndMaxAge,
  }) : super(key: key);

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

enum Gender { Male, Female, Other }

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  double? _startValue;
  double? _endValue;
  Gender? _selectedGender;

  RangeValues values = RangeValues(18, 60);

  @override
  void initState() {
    _selectedGender = widget.gender[0] == "Female"
        ? Gender.Female
        : widget.gender[0] == "Male"
            ? Gender.Male
            : Gender.Other;

    _startValue = widget.minAndMaxAge[0].toDouble();
    _endValue = widget.minAndMaxAge[1].toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
                largePaddingHor,
                Text("Filter & Show",
                    style: textStyleTextBold.copyWith(fontSize: 24)),
              ],
            ),
            divider,
            smallPaddingVert,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Age Range',
                  style: textStyleTextBold,
                ),
                Text(
                  "${_startValue!.truncate()} - ${_endValue!.truncate()}",
                  style: textStyleTextMeduimBold,
                )
              ],
            ),
            mediumPaddingVert,
            RangeSlider(
              values: RangeValues(_startValue!, _endValue!),
              min: 0,
              max: 100,
              onChanged: (RangeValues values) {
                setState(() {
                  _startValue = values.start;
                  _endValue = values.end;
                });
              },
            ),
            mediumPaddingVert,
            divider,
            smallPaddingVert,
            Text(
              'Show Me',
              style: textStyleTextBold,
            ),
            mediumPaddingVert,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Radio(
                      value: Gender.Male,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    Text(
                      'Men',
                      style: textStyleTextBold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: Gender.Female,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    Text(
                      'Women',
                      style: textStyleTextBold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: Gender.Other,
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      },
                    ),
                    Text(
                      'Other',
                      style: textStyleTextBold,
                    ),
                  ],
                ),
              ],
            ),
            mediumPaddingVert,
            divider,
            smallPaddingVert,
            Text(
              'Relationship Goals',
              style: textStyleTextBold,
            ),
            mediumPaddingVert,
            Wrap(
              runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 10,
              spacing: 5,
              children: [
                CustomTextContainer(
                    listInteresrt: widget.goalRelation, text: 'Dating 👩‍❤️‍👨'),
                CustomTextContainer(
                    listInteresrt: widget.goalRelation, text: 'Friendship 🙌'),
                CustomTextContainer(
                    listInteresrt: widget.goalRelation, text: 'Casual 😀'),
                CustomTextContainer(
                    listInteresrt: widget.goalRelation,
                    text: 'Serious Relationship 💍'),
              ],
            ),
            mediumPaddingVert,
            divider,
            smallPaddingVert,
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  colorText: primaryColor,
                  textButton: "Reset",
                  color: lightColor,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
                Expanded(
                    child: CustomButton(
                  colorText: whiteColor,
                  textButton: "Apply",
                  onPressed: () {
                    setState(() {
                      widget.minAndMaxAge[0] = _startValue!.toInt();
                      widget.minAndMaxAge[1] = _endValue!.toInt();
      
                      widget.gender[0] = _selectedGender.toString().substring(7);
                      print(widget.gender[0]);
                      Navigator.pop(context);
                    });
                  },
                )),
              ],
            ),
            mediumPaddingVert,
          ],
        ),
      ),
    );
  }
}
