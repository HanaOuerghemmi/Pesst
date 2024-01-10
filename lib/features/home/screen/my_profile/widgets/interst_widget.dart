import 'package:flutter/material.dart';
import 'package:pesst/features/auth/screens/signup_widget/interest_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/request_showpop.dart';
import 'package:pesst/widgets/custom_button.dart';


class InterstWidgetProfile extends StatefulWidget {
  final List<String> interests;
  // final Function(List<String>) updateList;

  const InterstWidgetProfile({super.key, required this.interests});

  @override
  State<InterstWidgetProfile> createState() => _InterstWidgetProfileState();
}

class _InterstWidgetProfileState extends State<InterstWidgetProfile> {
  List<String> currentInterests = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize the current interests with the initial interests.
  //   currentInterests = List.from(widget.interests);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Intersets"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: 
            
            InterstList(
              interests: widget.interests
            )
           
          ),
          
          Text(widget.interests.length.toString()),
        ],
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomButton(
          colorText: whiteColor,
          textButton: "ok(${widget.interests.length} / 5 )",
          onPressed: () {
            if (widget.interests.length != 5) {
              showSnackBar(context, "select 5 intersts");
            } else {
             
                Navigator.pop(context);
              
            }
          },
        ),
      ),
    );
  }
}
