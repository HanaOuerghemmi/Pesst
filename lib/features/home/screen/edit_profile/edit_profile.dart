import "dart:io";

import "package:country_picker/country_picker.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:intl/intl.dart";
import "package:pesst/features/home/controller/home_controller.dart";

import 'package:pesst/features/home/screen/edit_profile/widgets/custom_edit_image_container.dart';
import 'package:pesst/features/home/screen/my_profile/profile_screen.dart';
import 'package:pesst/features/home/screen/my_profile/widgets/custom_multi_choice.dart';
import 'package:pesst/features/home/screen/my_profile/widgets/custom_text_profile.dart';
import 'package:pesst/features/home/screen/my_profile/widgets/interst_widget.dart';
import 'package:pesst/features/home/screen/my_profile/widgets/relation_widget.dart';
import "package:pesst/models/user_model.dart";
import "package:pesst/utils/colors.dart";
import "package:pesst/utils/helper_padding.dart";
import "package:pesst/widgets/custom_button.dart";

import '../../../../utils/helper_textstyle.dart';


class EditProfile extends ConsumerStatefulWidget {
  static const routeName = '/edit-profile';
  final String userid;
  final UserModel user;
  const EditProfile({required this.userid, required this.user});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  final NicknameController = TextEditingController();
  final birthController = TextEditingController();
  final JobController = TextEditingController();
  final CountryController = TextEditingController();
  final aboutController = TextEditingController();

  List<String> gender = [" "];
  List<File?> listImages = [];

  List<String>? listImagesUser = [];
  List<String> Newinterests = [];
  List<String> NewInterests2 = [];
  List<String> newRelationGoals = [" "];
  Country? country;

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
            CountryController.text = _country.name;
          });
          print(country);
        });
  }

  void editInformationProfile(BuildContext context) async {
    String name = NicknameController.text.trim().isEmpty
        ? widget.user.name
        : NicknameController.text.trim();
    String birth = birthController.text.trim().isEmpty
        ? widget.user.birthday
        : birthController.text.trim();
    String job = JobController.text.trim().isEmpty
        ? widget.user.jobTitle
        : JobController.text.trim();
    String country = CountryController.text.trim().isEmpty
        ? widget.user.country
        : CountryController.text.trim();
    String about = aboutController.text.trim().isEmpty
        ? widget.user.bio
        : aboutController.text.trim();
    List<dynamic> interst =
        Newinterests.isEmpty ? widget.user.interests : Newinterests;
    String gend = gender.isEmpty ? widget.user.gender : gender[0];
    String relation = newRelationGoals.isEmpty
        ? widget.user.relationGoals
        : newRelationGoals[0];
    int age = birthController.text.trim().isEmpty
        ? widget.user.age
        : calculateage(birthController.text);

    await ref.read(homeControllerProvider).updateUser(
          widget.user.uid,
          // listImages,
          name,
          birth,
          job,
          country,
          about,
          interst,
          gend,
          relation,
          age,
          context,
        );

    Navigator.pop(context);

    print("update sucess");
  }

  int calculateage(String birthday) {
    DateTime userBirth = DateFormat('dd/MM/yyyy').parse(birthday);
    DateTime now = DateTime.now();
    int age = now.year - userBirth.year;
    return age;
  }

  @override
  void initState() {
    gender[0] = widget.user.gender;
    newRelationGoals[0] = widget.user.relationGoals;
    Newinterests = widget.user.interests as List<String>;
    listImagesUser = widget.user.imageURLs as List<String>;
    // listImageWithIndex.forEach((key, value) {
    //   if (key! >= listImagesUser!.length) {
    //     return;
    //   }
    //   listImageWithIndex[key] = listImagesUser![key];
    // });
    // print(listImageWithIndex);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 24,
            ),
          ),
          title: Text(
            "Edit Profile",
            style: textStyleSubtitle,
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //!pic
              Container(
                height: 360,
                child: ImagesEditContainer(
                  listImages: listImages,
                  listUrlsImages: listImagesUser,
                ),
              ),
              mediumPaddingVert,

              //! nickname + birthday
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "NickName",
                        style: textStyleTextBold,
                      ),
                      CustomProfileTextField(
                        nameTextField: widget.user.name,
                        controller: NicknameController,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Birthday",
                        style: textStyleTextBold,
                      ),
                      CustomProfileTextField(
                        readonly: true,
                        nameTextField: widget.user.birthday,
                        controller: birthController,
                        prefixIcon: IconButton(
                          icon: Icon(
                            Icons.calendar_today,
                            color: primaryColor,
                          ),
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateFormat("dd/MM/yyyy").parse(widget
                                  .user
                                  .birthday), //?? DateTime.now().subtract(Duration(days: 365*18)), //get today's date
                              firstDate: DateTime.now().subtract(Duration(
                                  days: 365 *
                                      60)), // - not to allow to choose before today.
                              lastDate: DateTime.now()
                                  .subtract(Duration(days: 365 * 18)),
                            );
                            if (pickedDate != null) {
                              String formattedDate = DateFormat('dd/MM/yyyy')
                                  .format(
                                      pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                              print(formattedDate);

                              setState(() {
                                birthController.text =
                                    formattedDate; //set foratted date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              mediumPaddingVert,
              //!gender

              Text(
                "Gender",
                style: textStyleTextBold,
              ),
              smallPaddingVert,
              CustomMultiChoiceTextField(
                gender: gender,
              ),
              // CustomShapes(
              //   gender: gender,
              //   withContainer: 70,
              //   heightContainer: 80,
              // ),
              mediumPaddingVert,
              //! job title
              Text(
                "Job title",
                style: textStyleTextBold,
              ),
              smallPaddingVert,

              CustomProfileTextField(
                width: double.maxFinite,
                nameTextField: widget.user.jobTitle,
                controller: JobController,
              ),
              //! living in
              mediumPaddingVert,
              Text(
                "Living",
                style: textStyleTextBold,
              ),
              smallPaddingVert,

              CustomProfileTextField(
                readonly: true,
                width: double.maxFinite,
                nameTextField: widget.user.country,
                controller: CountryController,
                prefixIcon: IconButton(
                    onPressed: () {
                      pickCountry();
                    },
                    icon: Icon(
                      Icons.language_rounded,
                      color: primaryColor,
                    )),
              ),
              mediumPaddingVert,
              //! about me
              mediumPaddingVert,
              Text(
                "About me",
                style: textStyleTextBold,
              ),
              smallPaddingVert,
              CustomProfileTextField(
                width: double.maxFinite,
                nameTextField: widget.user.bio.isEmpty
                    ? 'Describe yourself in two sentences to make your profile stand out. What are your key qualities or interests that you want someone to know?'
                    : widget.user.bio,
                controller: aboutController,
                maxLength: 200,
                maxLines: 4,
              ),
              mediumPaddingVert,
              //! interest
              CartInfoEditProfile(
                titleHeader: "Interest",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InterstWidgetProfile(
                                interests: Newinterests,
                              ))).then((value) {
                    setState(() {});
                  });
                },
                widgetInfo: SectionWidget(
                  nameSection: "",
                  hadtitle: false,
                  interests: Newinterests.length > 4
                      ? Newinterests
                      : widget.user.interests as List<String>,
                ),
              ),
              smallPaddingVert,

              //! relations goals
              smallPaddingVert,
              CartInfoEditProfile(
                titleHeader: "Relation Goals",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RelationWidgetProfile(
                                relationGoals: newRelationGoals,
                              ))).then((value) {
                    setState(() {});
                  });
                },
                widgetInfo: RelationshipGoalWidget(
                  title: "",
                  hadtile: true,
                  relationGoals: newRelationGoals[0],
                ),
              ),

              //! save and cancel button
              mediumPaddingVert,
              (Row(
                children: [
                  Expanded(
                      child: CustomButton(
                    colorText: primaryColor,
                    textButton: "cancel",
                    color: lightColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )),
                  Expanded(
                      child: CustomButton(
                          colorText: whiteColor,
                          textButton: "save",
                          onPressed: () {
                            editInformationProfile(context);
                          })),
                ],
              ))
            ]),
          ),
        ));
  }
}

class ImagesEditContainer extends StatelessWidget {
  const ImagesEditContainer({
    super.key,
    required this.listImages,
    required this.listUrlsImages,
  });

  final List<File?> listImages;
  final List<dynamic>? listUrlsImages;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 0.2,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.66,
        ),
        itemCount: 6,
        itemBuilder: (BuildContext context, int index) {
          print(index);
          print("length is ${listUrlsImages?.length}");

          return (listUrlsImages!.length > index)
              ? CustomEditImageContainer(
                  listImages: listImages,
                  // imageUrl: listImages[index],
                  urlImageFromFirebase: listUrlsImages?.elementAt(index))
              : CustomEditImageContainer(
                  listImages: listImages,
                );
        },
      ),
    );
  }
}
