// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pesst/features/home/controller/home_controller.dart';
import 'package:pesst/features/home/screen/user_profile/user_profile.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/helper_textstyle.dart';
import 'package:pesst/utils/modal_bottom_sheet.dart';


class HomeScreen extends StatefulWidget {
  final UserModel userModel;

  const HomeScreen({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> goalRelation = [];
  List<String> gender = [""];
  List<int> minAndMaxAge = [18, 65];
  void _showAgeRangePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalBottomSheet(
          minAndMaxAge: minAndMaxAge,
          goalRelation: goalRelation,
          gender: gender,
        );
      },
    ).then((value) => {
          setState(() {
            print(gender[0]);
            print(minAndMaxAge[0]);
            print(minAndMaxAge[1]);
          }),
        });
  }

  @override
  void initState() {
    goalRelation = [''];
    gender[0] = widget.userModel.gender == "Female"
        ? 'Male'
        : widget.userModel.gender == 'Male'
            ? "Female"
            : "Other";
    print(goalRelation);
    print(gender);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/images/logo.png",
            height: 30,
            width: 30,
          ),
        ),
        title: Text(
          "Pesst",
          style: textStyleSubtitle,
        ),
        centerTitle: true,
        actions: [
          // CircleAvatar(
          //   backgroundColor: purpleColor,
          //   child: Text(
          //     widget.userModel.numberPisit.toString(),
          //     style: textStyleTextBold,
          //   ),
          // ),
          IconButton(
              onPressed: () {
                _showAgeRangePicker(context);
                setState(() {});
              },
              icon: const FaIcon(
                FontAwesomeIcons.sliders,
                color: primaryColor,
                
              )),
        ],
      ),
      body: BodyHomeScreen(
        gender: gender[0], //!= '' ? gender[0] : "",
        ownUserModel: widget.userModel,
        // listOfGoalsRelationShip: goalRelation[0] != '' ? goalRelation : [''],
        minAndMaxAge: minAndMaxAge,
      ),
    );
  }
}

class BodyHomeScreen extends ConsumerWidget {
  final UserModel ownUserModel;
  final List<int>? minAndMaxAge;
  final String? gender;
  final List<String>? listOfGoalsRelationShip;
  const BodyHomeScreen({
    required this.ownUserModel,
    this.minAndMaxAge,
    this.gender,
    this.listOfGoalsRelationShip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: ref.watch(homeControllerProvider).getAllUsers(
              minAndMaxAge: minAndMaxAge,
              gender: gender,
              listOfGoalsRelationShip: listOfGoalsRelationShip,
            ),
        // gender != null
        //     ?
        //     : ref.watch(homeControllerProvider).getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //! widget in waiting Users similar to real screen
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                //  physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: greyColor.shade300,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: SizedBox(),
                  );
                },
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          var users = snapshot.data!;

          if (users.isEmpty) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                //  physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.4),
                ),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final userModel = users[index];
                  return ItemListUsers(
                    userModel: userModel,
                    ownUserModel: ownUserModel,
                  );
                },
              ),
            );
          }
        });
  }
}

class ItemListUsers extends StatelessWidget {
  const ItemListUsers({
    Key? key,
    required this.userModel,
    required this.ownUserModel,
  }) : super(key: key);

  final UserModel userModel;
  final UserModel ownUserModel;
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => UserProfile(userModel: userModel, ownUserModel: ownUserModel,),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
         Navigator.of(context).push(_createRoute());
        // Navigator.pushNamed(
        //   context,
        //   UserProfile.routeName,
        //   arguments: {"userModel": userModel, "ownUserModel": ownUserModel},
        // );
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: CachedNetworkImage(
              imageUrl: userModel.imageURLs![0],
              fit: BoxFit.cover,
              height: 400,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, blackColor],
              ),
            ),
          ),
          Positioned(
              bottom: 10,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userModel.name.length > 8
                              ? userModel.name.substring(0, 7) +
                                  "..." +
                                  " ( ${userModel.age})"
                              : userModel.name + " ( ${userModel.age})",
                          style: textStyleTextBold.copyWith(color: whiteColor),
                        ),
                        microPaddingVert,
                        Text(
                          userModel.jobTitle.length > 10
                              ? userModel.jobTitle.substring(0, 9) + "..."
                              : userModel.jobTitle,
                          style: textStyleTextMeduimBold.copyWith(
                              color: whiteColor),
                        ),
                        microPaddingVert,
                      ],
                    ),
                    // Center(
                    //   child: CircleAvatar(
                    //     radius: 26,
                    //     backgroundColor: whiteColor,
                    //     child: Image.asset(
                    //       "assets/images/logo_request_active.png",
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
