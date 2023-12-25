import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pesst/features/auth/screens/widgets/customtext_field.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pisiit/features/auth/widgets/customtext_field.dart';
import 'package:pisiit/features/auth/widgets/widget_title.dart';
import 'package:pisiit/utils/colors.dart';
import 'package:pisiit/utils/helper_padding.dart';
import 'package:pisiit/widgets/custom_button.dart';

class InfoWidget extends StatefulWidget {
  final TabController tabController;

  TextEditingController jobController;

  InfoWidget({
    super.key,
    required this.tabController,
    required this.jobController,
  });

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WidgetTitle(
              title: "Discover Your Careers and Connections 🌐💼",
              subTitle:
                  "Reveal Your Job Status and Country Living for Meaningful Connections! Share your professional journey and explore matches who resonate with your lifestyle"),
          mediumPaddingVert,
          CustomTextField(
            hintText: "Software developer",
            controller: widget.jobController,
          ),
        ],
      ),
    );
  }
}
