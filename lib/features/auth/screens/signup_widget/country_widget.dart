import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:pesst/features/auth/screens/widgets/title_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pisiit/features/auth/widgets/customtext_field.dart';
import 'package:pisiit/features/auth/widgets/widget_title.dart';
import 'package:pisiit/utils/colors.dart';
import 'package:pisiit/utils/helper_padding.dart';
import 'package:pisiit/widgets/custom_button.dart';

class WidgetCountry extends StatefulWidget {
  final TabController tabController;
  final List<String> country;

  WidgetCountry(
      {super.key, required this.tabController, required this.country});

  @override
  State<WidgetCountry> createState() => _WidgetCountryState();
}

class _WidgetCountryState extends State<WidgetCountry> {
  Country? country;
  @override
  void pickCountry() {
    showCountryPicker(
        context: context,
        countryListTheme: const CountryListThemeData(
            bottomSheetHeight: 500,
            inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: lightColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
            backgroundColor: whiteColor),
        onSelect: (Country _country) {
          setState(() {
            country = _country;
            widget.country[0] = country!.displayNameNoCountryCode;
          });
          print(country);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const WidgetTitle(
              title: "DConnections 🌐💼",
              subTitle:
                  "Reveal Your Country Living for Meaningful Connections!"),
          mediumPaddingVert,
          //country

          GestureDetector(
            onTap: pickCountry,
            child: Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                color: greyColor.shade200,
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              child: Center(
                child: Text(
                  country?.name ?? "Your Country🌐",
                  style: TextStyle(
                      fontSize: 26,
                      color: country != null ? blackColor : Colors.grey[500],
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          mediumPaddingVert,
        ],
      ),
    );
  }
}
