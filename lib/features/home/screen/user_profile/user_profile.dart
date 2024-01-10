// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/home/controller/home_controller.dart';
import 'package:pesst/features/home/screen/my_profile/profile_screen.dart';
import 'package:pesst/features/home/screen/widgets/appbar_profile_user.dart';
import 'package:pesst/features/home/screen/widgets/image_widget.dart';
import 'package:pesst/features/home/screen/widgets/info_user_profile.dart';
import 'package:pesst/models/user_model.dart';
import 'package:pesst/utils/colors.dart';
import 'package:pesst/utils/helper_padding.dart';
import 'package:pesst/utils/request_showpop.dart';

class UserProfile extends StatelessWidget {
  static const routeName = '/user-profile-screen';
  final UserModel userModel;
  final UserModel ownUserModel;
  const UserProfile({
    Key? key,
    required this.userModel,
    required this.ownUserModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<bool> listBoolPictures = [
      true,
      false,
      false,
      false,
      false,
      false,
    ];
    for (int index = 1; index <= 5; index++) {
      if (userModel.imageURLs!.length > index) {
        print(userModel.imageURLs!.length);

        listBoolPictures[index] = true;
      } else {
        listBoolPictures[index] = false;
      }
    }

    return Scaffold(
      appBar: AppBarProfileUser(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              smallPaddingVert,
              ImageWidget(
                imageUrl: userModel.imageURLs![0],
              ),
              smallPaddingVert,
              InfoUserWidget(
                user: userModel,
                isProfile: false,
                userid: userModel.uid,
                name: userModel.name,
                age: userModel.age.toString(),
                gender: userModel.gender,
                jobTitle: userModel.jobTitle,
                country: userModel.country
                    .substring(0, userModel.country.length - 5),
              ),
              smallPaddingVert,
              listBoolPictures[1] ? mediumPaddingVert : const SizedBox(),
              listBoolPictures[1]
                  ? ImageWidget(
                      imageUrl: userModel.imageURLs![1],
                    )
                  : const SizedBox(),
              smallPaddingVert,
              divider,
              smallPaddingVert,
              AboutMeWidget(
                aboutMe: userModel.bio.trim() == ""
                    ? "Describe yourself in two sentences to make your profile stand out. What are your key qualities or interests that you want someone to know? "
                    : userModel.bio,
              ),
              mediumPaddingVert,
              listBoolPictures[2] ? mediumPaddingVert : const SizedBox(),
              listBoolPictures[2]
                  ? ImageWidget(
                      imageUrl: userModel.imageURLs![2],
                    )
                  : const SizedBox(),
              smallPaddingVert,
              divider,
              smallPaddingVert,
              SectionWidget(
                nameSection: "Interests",
                interests: userModel.interests as List<String>,
              ),
              mediumPaddingVert,
              listBoolPictures[3] ? mediumPaddingVert : const SizedBox(),
              listBoolPictures[3]
                  ? ImageWidget(
                      imageUrl: userModel.imageURLs![3],
                    )
                  : const SizedBox(),
              smallPaddingVert,
              divider,
              smallPaddingVert,
              RelationshipGoalWidget(
                title: "Relation Goals",
                relationGoals: userModel.relationGoals,
              ),
              listBoolPictures[4] ? mediumPaddingVert : const SizedBox(),
              listBoolPictures[4]
                  ? ImageWidget(
                      imageUrl: userModel.imageURLs![4],
                    )
                  : const SizedBox(),
              smallPaddingVert,
              divider,
              smallPaddingVert,
              listBoolPictures[5] ? mediumPaddingVert : const SizedBox(),
              listBoolPictures[5]
                  ? ImageWidget(
                      imageUrl: userModel.imageURLs![5],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
      //request part

      // bottomNavigationBar:

      //  Container(

      //    color: Colors.transparent,
      //    child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [

      //       mediumPaddingHor,
      //       Consumer(builder: (context, ref, child) {
      //         return FutureBuilder<bool>(
      //             future: ref
      //                 .watch(homeControllerProvider)
      //                 .canSendRequest(userModel.uid),
      //             builder: (context, snapshot) {
      //               if (snapshot.connectionState == ConnectionState.waiting) {
      //                 return  Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.all(16),
      //                       child: Container(
      //                         width: 60,
      //                         height: 60,
      //                       decoration: BoxDecoration(
      //                         color: greyColor.shade300,
      //                         shape: BoxShape.circle
      //                       ),
      //                       ),
      //                     ),
      //                     Padding(
      //                       padding: const EdgeInsets.all(16),
      //                       child: Container(
      //                         width: 60,
      //                         height: 60,
      //                       decoration: BoxDecoration(
      //                         color: greyColor.shade300,
      //                         shape: BoxShape.circle
      //                       ),
      //                       ),
      //                     ),
      //                   ],
      //                 ); //CircularProgressIndicator();
      //               }

      //               if (snapshot.hasError) {
      //                 return Text('Error: ${snapshot.error}');
      //               }

      //               bool isUserInCollection = snapshot.data!;

      //               return

      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //    //! close circle
      //     Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: Container(
      //           width: 60,
      //           height: 60,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             // You can set your desired color here
      //             border: Border.all(
      //               color: primaryColor,
      //               width: 2.0,
      //             ),
      //           ),
      //           child: Center(
      //             child: IconButton(
      //               onPressed: () {
      //                 Navigator.pop(context);
      //               },
      //               icon: Icon(
      //                 Icons.close,
      //                 size: 30,
      //                 color: primaryColor,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //                   //? request logo
      //                   GestureDetector(
      //                           onTap: isUserInCollection
      //                       ? (){
      //                         showSnackBar(context, "you send a pesst for this profile verif ur chatpage");
      //                       }
      //                       : () {
      //                             simplePisitDialog(
      //                                 context: context,
      //                                 sender: ownUserModel,
      //                                 recipient: userModel);
      //                           },
      //                           child: Padding(
      //                             padding: const EdgeInsets.all(16.0),
      //                             child: Container(
      //                               width: 60.0,
      //                               height: 60.0,
      //                               decoration: BoxDecoration(
      //                                 shape: BoxShape.circle,
      //                                 // You can set your desired color here
      //                                 border: Border.all(
      //                                   color: primaryColor,
      //                                   width: 2.0,
      //                                 ),
      //                               ),
      //                               child: Center(
      //                                   child:
      //                                   isUserInCollection ?
      //                                   Image.asset(
      //                                 "assets/images/logo_request.png",
      //                                 height: 30,
      //                               ):
      //                                Image.asset(
      //                                 "assets/images/logo.png",
      //                                 height: 30,
      //                               )

      //                               ) ,
      //                             ),
      //                           ),
      //                         ),
      //                 ],
      //               );
      //             });
      //       })
      //     ],
      //          ),
      //  ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Consumer(builder: (context, ref, child) {
        return FutureBuilder<bool>(
            future:
                ref.watch(homeControllerProvider).canSendRequest(userModel.uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: greyColor.shade300,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes the position of the shadow
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes the position of the shadow
                            ),
                          ],
                          color: greyColor.shade300,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ); //CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              bool isUserInCollection = snapshot.data!;

              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //! close circle
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(
                                0, 3), // changes the position of the shadow
                          ),
                        ],
                        color: whiteColor.withOpacity(0.8),
                        shape: BoxShape.circle,
                        // You can set your desired color here
                        border: Border.all(
                          color: primaryColor,
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //? request logo
                  GestureDetector(
                    onTap: isUserInCollection
                        ? () {
                            showSnackBar(context,
                                "you send a pesst for this profile verif ur chatpage");
                          }
                        : () {
                            simplePisitDialog(
                                context: context,
                                sender: ownUserModel,
                                recipient: userModel);
                          },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        width: 60.0,
                        height: 60.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(
                                  0, 3), // changes the position of the shadow
                            ),
                          ],
                          color: isUserInCollection
                              ? whiteColor.withOpacity(0.5)
                              : whiteColor.withOpacity(0.8),
                          shape: BoxShape.circle,
                          // You can set your desired color here
                          border: Border.all(
                            color: primaryColor,
                            width: 2.0,
                          ),
                        ),
                        child: Center(
                            child: isUserInCollection
                                ? Image.asset(
                                    "assets/images/logo_request.png",
                                    height: 30,
                                  )
                                : Image.asset(
                                    "assets/images/logo.png",
                                    height: 30,
                                  )),
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
