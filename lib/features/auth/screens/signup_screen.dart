import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/common/forget_password/otp_verif_widgets.dart';
import 'package:pesst/common/functions/otp_function.dart';
import 'package:pesst/common/verif_mail.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:pesst/features/auth/screens/signup_widget/birthday_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/country_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/email_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/gender_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/images_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/info_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/interest_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/nickname_widget.dart';
import 'package:pesst/features/auth/screens/signup_widget/relationgoals_widget.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/widgets/custom_button.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = '/signup-screen';
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  //! controller signup
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();

  /// otp
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  final otp5Controller = TextEditingController();
  final otp6Controller = TextEditingController();
  List<String> otp = [];
  List<String> newotp = [];
  void updateOTP(List<String> newOTP) {
    setState(() {
      otp = newOTP;
    });
  }

  final dayController = TextEditingController();
  final monthController = TextEditingController();
  final yearController = TextEditingController();
  FocusNode dayfocusNode = FocusNode();
  FocusNode monthfocusNode = FocusNode();
  FocusNode yearfocusNode = FocusNode();

  List<String> gender = [""];
  List<String> relationGoals = [""];
  List<File> listImages = [];
  List<String> interests = [];
  List<String> country = [""];
  bool isChecked = false;
  bool isLoading = false;

  //! key form for ech setep in tabview
  final GlobalKey<FormState> _formKeyemail = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyname = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    dayfocusNode.addListener(() {
      if (!dayfocusNode.hasFocus && dayController.text.length == 2) {
        // Move focus to the next field when the user has entered 2 characters
        FocusScope.of(context).requestFocus(monthfocusNode);
      }
    });
    monthfocusNode.addListener(() {
      if (!monthfocusNode.hasFocus && monthController.text.length == 2) {
        // Move focus to the next field when the user has entered 2 characters
        FocusScope.of(context).requestFocus(yearfocusNode);
      }
    });
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    dayfocusNode.dispose();
    monthfocusNode.dispose();
    yearfocusNode.dispose();
    super.dispose();
  }

//! function signup
  void registerWithEmailAndPassword(BuildContext context,
      TabController tabController, PageController pageController) {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    print(password);

    if (email.isNotEmpty && password.isNotEmpty) {
      ref.read(authControllerProvider).signUpWithEmailAndPassword(
          context: context,
          email: email,
          password: password,
          imageURLs: listImages,
          name: _nameController.text,
          gender: gender[0],
          relationGoals: relationGoals[0],
          age: calculateAge(
                  "${dayController.text}/${monthController.text}/${yearController.text}")
              .toString(),
          birthday:
              "${dayController.text}/${monthController.text}/${yearController.text}",
          interests: interests,
          country: country[0],
          jobTitle: _jobController.text);

      // tabController.animateTo(tabController.index + 1);
      // pageController.animateToPage(
      //   tabController.index,
      //   duration: const Duration(milliseconds: 500),
      //   curve: Curves.easeInOut,
      // );
    } else {
      // showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

//! function for tabview confirm befor continue
  void FunctionTabview(
      TabController tabController, PageController pageController) async {
    bool isFormValid = false;
    bool isEmail;

    switch (tabController.index) {
      case 0:
        isFormValid = _formKeyemail.currentState?.validate() ?? false;
        if (!isFormValid || !isChecked) {
          showSnackBar(context, "error check i agree $isChecked");
          return;
        } else {
          bool isEmailAvailableResult =
              await isEmailAvailable(emailController.text);
          print(isEmailAvailableResult);
          if (!isEmailAvailableResult) {
            showSnackBar(context, 'Email is not available mail had accoount');
            print('Email is not available mail had accoount');
            return;
          } else {
            print('Email is available');
            // continue to the next case
            //send otp
            otp = generateOTP();
            sendOTPToEmail(emailController.text, otp);
          }
        }
        break;
      case 1:
        String otpwriten = otp1Controller.text +
            otp2Controller.text +
            otp3Controller.text +
            otp4Controller.text +
            otp5Controller.text +
            otp6Controller.text;
        if (otp[0] != otpwriten) {
          showSnackBar(context, 'otp non valid verif code');
          return;
        }
        break;

      case 2:
        isFormValid = _formKeyname.currentState?.validate() ?? false;
        if (_nameController.text.isEmpty || _nameController.text.length < 3) {
          showSnackBar(context, "error name");
          return;
        }
        break;

      case 3:
        String day = dayController.text;
        String month = monthController.text;
        String year = yearController.text;
        if (day == "" || month == "" || year == "") {
          showSnackBar(context, "error birthday");
          return;
        }
        break;
      case 4:
        if (gender[0].isEmpty) {
          showSnackBar(context, "error gender");
          return;
        }
        break;
      case 5:
        if (relationGoals[0].isEmpty) {
          showSnackBar(context, "error relation goals");
          return;
        }
        break;
      case 6:
        if (interests.length < 5) {
          showSnackBar(context, "select 5 interset");
          return;
        }
        break;
      case 7:
        if (country[0].isEmpty) {
          showSnackBar(context, "select country");
          return;
        }
        break;
      case 8:
        if (_jobController.text.isEmpty || _jobController.text.length < 4) {
          showSnackBar(context, "write job");
          return;
        }
        break;

      case 9:
        if (listImages.length >= 1) {
          registerWithEmailAndPassword(
            context,
            tabController,
            pageController,
          );
          return;
        }
        showSnackBar(context, "upload image");
        return;
    }
    // If no validation errors, proceed to the next tab with animation
    setState(() {
      tabController.animateTo(tabController.index + 1);
      pageController.animateToPage(
        tabController.index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 10,
      child: Builder(
        builder: (BuildContext context) {
          final TabController tabController = DefaultTabController.of(context);
          final PageController pageController =
              PageController(initialPage: tabController.index);

          return Scaffold(
            appBar: AppBar(
                centerTitle: true,
                title: SizedBox(
                  width: 220,
                  child: tabController.index != 0
                      ? LinearProgressIndicator(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(12)),
                          minHeight: 10,
                          backgroundColor: greyColor,
                          color: blueColor,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(primaryColor),
                          value: (tabController.index / 6).toDouble(),
                        )
                      : const SizedBox(),
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    tabController.index = index;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Form(
                    key: _formKeyemail,
                    child: WidgetEmail(
                      tabController: tabController,
                      emailController: emailController,
                      passwordController: passwordController,
                      isChecked: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                          print(isChecked);
                        });
                      },
                    ),
                  ),
                  OtpVerifWWidget(
                      emailController: emailController,
                      otp: otp,
                      otp1Controller: otp1Controller,
                      otp2Controller: otp2Controller,
                      otp3Controller: otp3Controller,
                      otp4Controller: otp4Controller,
                      otp5Controller: otp5Controller,
                      otp6Controller: otp6Controller),
                  WidgetNickName(
                      tabController: tabController,
                      nameController: _nameController),
                  WidgetBirthday(
                    tabController: tabController,
                    dayController: dayController,
                    monthController: monthController,
                    yearController: yearController,
                    dayfocusNode: dayfocusNode,
                    monthfocusNode: monthfocusNode,
                    yearfocusNode: yearfocusNode,
                  ),
                  GenderWidget(
                    tabController: tabController,
                    gender: gender,
                  ),
                  RelationGoalsWidget(
                    tabController: tabController,
                    relationGoals: relationGoals,
                  ),
                  InterestWidget(
                    tabController: tabController,
                    interests: interests,
                  ),
                  WidgetCountry(
                    country: country,
                    tabController: tabController,
                  ),
                  InfoWidget(
                    tabController: tabController,
                    jobController: _jobController,
                  ),
                  WidgetImages(
                    tabController: tabController,
                    listImages: listImages,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.only(bottom: 25.0),
              child:
                  // kIsWeb
                  //     ? Row(
                  //         children: [
                  //           Expanded(
                  //             child: CustomButton(
                  //               colorText: whiteColor,
                  //               textButton:
                  //                   tabController.index == 0 ? "Sign " : "Prev",
                  //               onPressed: () {
                  //                 setState(() {
                  //                   tabController
                  //                       .animateTo(tabController.index - 1);
                  //                   pageController.animateToPage(
                  //                     tabController.index,
                  //                     duration: const Duration(milliseconds: 500),
                  //                     curve: Curves.easeInOut,
                  //                   );
                  //                 });
                  //               },
                  //             ),
                  //           ),
                  Row(
                children: [
                  // prev button
                  Expanded(
                    child: tabController.index != 0
                        ? CustomButton(
                            colorText: whiteColor,
                            textButton: "Prev",
                            onPressed: () {
                              setState(() {
                                tabController
                                    .animateTo(tabController.index - 1);
                                pageController.animateToPage(
                                  tabController.index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              });
                            },
                          )
                        : SizedBox(
                            width: 10,
                          ),
                  ),

                  Expanded(
                    child: CustomButton(
                        colorText: whiteColor,
                        textButton: tabController.index == 0
                            ? "Sign Up"
                            : tabController.index == 6
                                ? "Continue (${interests.length}/5)"
                                : "Continue",
                        onPressed: () {
                          FunctionTabview(tabController, pageController);
                        }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
