// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:pesst/features/home/controller/home_controller.dart';

import 'package:pesst/features/home/screen/home/screen/home/home_screen.dart';
import 'package:pesst/features/home/screen/home/screen/my_profile/profile_screen.dart';

import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_textstyle.dart';

import '../../../../chat/screen/chat_screen.dart';

class HomeApplicationScreen extends StatefulWidget {
  UserModel? userModel;
  HomeApplicationScreen({
    Key? key,
    this.userModel,
  }) : super(key: key);

  @override
  State<HomeApplicationScreen> createState() => _HomeApplicationScreenState();
}

class _HomeApplicationScreenState extends State<HomeApplicationScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    setState(() {
      _pageController.animateToPage(
        selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          HomeScreen(
            userModel: widget.userModel!,
          ),
          ChatsScreen(
          //  userModel: widget.userModel!,
          ),
          ProfileScreen(
            userModel: widget.userModel!,
          ),
        ],
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, child) {
        return StreamBuilder<int>(
            stream: ref.watch(homeControllerProvider).numberRequest(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return BottomNavigationBar(
                  selectedLabelStyle: TextStyle(color: primaryColor),
                  selectedIconTheme: IconThemeData(color: primaryColor),
                  unselectedIconTheme: IconThemeData(color: greyColor),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _currentIndex,
                  onTap: _onItemTapped,
                  backgroundColor: whiteColor,
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/svg/home but light.svg",
                        width: 24,
                        height: 24,
                      ),
                      // FaIcon(FontAwesomeIcons.house),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.comments),
                      label: "Chats",
                    ),
                    BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.user),
                      label: "Profile",
                    )
                  ],
                );
              }
              int numberOfRequests = snapshot.data!;
              return BottomNavigationBar(
                selectedLabelStyle: TextStyle(color: primaryColor),
                unselectedIconTheme: IconThemeData(color: greyColor),
                type: BottomNavigationBarType.fixed,
                currentIndex: _currentIndex,
                onTap: _onItemTapped,
                backgroundColor: whiteColor,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    activeIcon: FaIcon(
                      FontAwesomeIcons.house,
                      color: primaryColor,
                    ),
                    //  SvgPicture.asset(
                    //   "assets/svg/home but light.svg",
                    //   height: 24,
                    //   width: 24,
                    //   color: primaryColor,
                    // ),
                    icon: SvgPicture.asset(
                      "assets/svg/home but light.svg",
                      height: 24,
                      width: 24,
                      color: primaryColor,
                      //greyColor,
                    ),
                    //FaIcon(FontAwesomeIcons.house),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    activeIcon: numberOfRequests == 0
                        ? FaIcon(
                            FontAwesomeIcons.solidComments,
                            color: primaryColor,
                          )
                        : badges.Badge(
                            badgeStyle: BadgeStyle(
                              badgeColor: whiteColor,
                              borderSide:
                                  BorderSide(width: 2, color: primaryColor),
                              padding: EdgeInsets.all(5),
                            ),
                            badgeAnimation: badges.BadgeAnimation.rotation(
                              animationDuration: Duration(seconds: 0),
                              colorChangeAnimationDuration:
                                  Duration(seconds: 0),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            badgeContent: Text(
                              numberOfRequests.toString(),
                              style: TextStyle(color: primaryColor),
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.solidComments,
                              color: primaryColor,
                            ),
                          ),
                    icon: numberOfRequests == 0
                        ? const FaIcon(
                            FontAwesomeIcons.comments,
                            color: primaryColor,
                          )
                        : badges.Badge(
                            badgeStyle: BadgeStyle(
                              badgeColor: primaryColor,
                              padding: EdgeInsets.all(5),
                            ),
                            badgeAnimation: badges.BadgeAnimation.rotation(
                              animationDuration: Duration(seconds: 0),
                              colorChangeAnimationDuration:
                                  Duration(seconds: 0),
                              loopAnimation: false,
                              curve: Curves.fastOutSlowIn,
                              colorChangeAnimationCurve: Curves.easeInCubic,
                            ),
                            badgeContent: Text(
                              numberOfRequests.toString(),
                              style: TextStyle(color: whiteColor),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.comments,
                              color: primaryColor,
                            ),
                          ),
                    label: "Chats",
                  ),
                  const BottomNavigationBarItem(
                    activeIcon: FaIcon(
                      FontAwesomeIcons.userLarge,
                      color: primaryColor,
                    ),
                    icon: FaIcon(
                      FontAwesomeIcons.user,
                      color: primaryColor,
                    ),
                    label: "Profile",
                  )
                ],
              );
            });
      }),
    );
  }
}
