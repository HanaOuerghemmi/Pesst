// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pesst/utils/colors.dart';



class CustomEditImageContainer extends StatefulWidget {
  File? imageUrl;
  List<File?> listImages;
  String? urlImageFromFirebase;
  int? index;
  CustomEditImageContainer({
    Key? key,
    this.imageUrl,
    required this.listImages,
    this.urlImageFromFirebase,
    this.index,
  }) : super(key: key);

  @override
  State<CustomEditImageContainer> createState() => _CustomImageContainerState();
}

class _CustomImageContainerState extends State<CustomEditImageContainer> {
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.imageUrl = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: GestureDetector(
        onTap: () async {
          await _pickImage();

          if (widget.imageUrl == null) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No image was selected.')));
          }

          if (widget.imageUrl != null) {
            print('Uploading ...');
            setState(() {
              //! add ! to verf
              widget.listImages.insert(widget.index!, widget.imageUrl!);
            });
          }
        },
        child: Container(
            height: 150,
            width: 100,
            decoration: BoxDecoration(
              color: greyColor.shade200,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: (widget.urlImageFromFirebase == null)
                ? (widget.imageUrl == null)
                    ? const Center(
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                      )
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              widget.imageUrl!,
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            right: -5,
                            top: -5,
                            child: CircleAvatar(
                              radius: 16,
                              backgroundColor: primaryColor,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: whiteColor,
                                  size: 16,
                                ),
                                onPressed: () {
                                  setState(() {
                                    //!!!!!! part one from file
                                    //   widget.listImages.remove(widget.imageUrl);
                                    widget.listImages[widget.index!] = null;
                                    widget.imageUrl = null;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                : Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.urlImageFromFirebase!,
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        right: -5,
                        top: -5,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: primaryColor,
                          child: IconButton(
                            icon: const Icon(
                              Icons.close,
                              color: whiteColor,
                              size: 16,
                            ),
                            onPressed: () {
                              setState(() {
                                //!!!!!! part one from link
                                widget.listImages[widget.index!] = null;
                                widget.imageUrl = null;
                                widget.urlImageFromFirebase = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
      ),
    );
  }
}
