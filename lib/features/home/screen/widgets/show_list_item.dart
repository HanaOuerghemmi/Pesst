import 'package:flutter/material.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_textstyle.dart';

class ShowListItem extends StatelessWidget {
  final List<String> list;
  const ShowListItem({
    Key? key,
    required this.list,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runAlignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runSpacing: 10,
      spacing: 5,
      children: list.map((text) => ItemList(text: text)).toList(),
    );
  }
}

class ItemList extends StatelessWidget {
  final String text;
  const ItemList({
    Key? key,
    required this.text,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: primaryColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: textStyleTextBold,
      ),
    );
  }
}
