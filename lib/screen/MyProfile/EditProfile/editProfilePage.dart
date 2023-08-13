// ignore_for_file: file_names, no_logic_in_create_state

import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/controller/getStorage.dart';
import 'package:devfinder/model/developers.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textfieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class EditProfilePage extends StatefulWidget {
  Developer developer;
  EditProfilePage({super.key, required this.developer});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool buttonState = false;
  final nameEditingController = TextEditingController();
  final usernameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final shortIntroEditingController = TextEditingController();
  final bioEditingController = TextEditingController();
  final locationEditingController = TextEditingController();
  final githubEditingController = TextEditingController();
  final hashnodeEditingController = TextEditingController();
  final twitterEditingController = TextEditingController();
  final youtubeEditingController = TextEditingController();
  final websiteEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameEditingController.text = widget.developer.name;
    usernameEditingController.text = widget.developer.username;
    emailEditingController.text = widget.developer.email;
    shortIntroEditingController.text = widget.developer.shortIntro;
    bioEditingController.text = widget.developer.bio;
    locationEditingController.text = widget.developer.location;
    githubEditingController.text = (widget.developer.socialGithub == "null")
        ? ""
        : widget.developer.socialGithub;
    hashnodeEditingController.text = (widget.developer.socialHashnode == "null")
        ? ""
        : widget.developer.socialHashnode;
    twitterEditingController.text = (widget.developer.socialTwitter == "null")
        ? ""
        : widget.developer.socialTwitter;
    youtubeEditingController.text = (widget.developer.socialYoutube == "null")
        ? ""
        : widget.developer.socialYoutube;
    websiteEditingController.text = (widget.developer.socialWebsite == "null")
        ? ""
        : widget.developer.socialWebsite;
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    usernameEditingController.dispose();
    emailEditingController.dispose();
    shortIntroEditingController.dispose();
    bioEditingController.dispose();
    locationEditingController.dispose();
    githubEditingController.dispose();
    hashnodeEditingController.dispose();
    twitterEditingController.dispose();
    youtubeEditingController.dispose();
    websiteEditingController.dispose();
    super.dispose();
  }

  void changeButtonState() {
    setState(() {
      buttonState = true;
    });
  }

  // TODO: Update profile throwing error.
  Future handleEditProfile(Developer currDeveloper) async {
    final storage = Get.put(StoreController());
    if (storage.isLogin) {
      Developer developer = Developer(
        name: nameEditingController.text,
        username: usernameEditingController.text,
        email: emailEditingController.text,
        shortIntro: shortIntroEditingController.text,
        bio: bioEditingController.text,
        location: locationEditingController.text,
        profileImage: currDeveloper.profileImage,
        socialGithub: githubEditingController.text == ""
            ? "null"
            : githubEditingController.text,
        socialHashnode: hashnodeEditingController.text == ""
            ? "null"
            : hashnodeEditingController.text,
        socialTwitter: twitterEditingController.text == ""
            ? "null"
            : twitterEditingController.text,
        socialYoutube: youtubeEditingController.text == ""
            ? "null"
            : youtubeEditingController.text,
        socialWebsite: websiteEditingController.text == ""
            ? "null"
            : websiteEditingController.text,
        url: currDeveloper.url,
        createdAt: currDeveloper.createdAt,
        skills: currDeveloper.skills,
        messages_received: currDeveloper.messages_received,
        messages_sent: currDeveloper.messages_sent,
      );
      final jsonData = developer.toJson();
      print(ApiConst.BASEURL +
          ApiConst.updateProfile.replaceAll("<str:pk>", storage.readUid()));
      print(jsonData);
      var response = await Api().put(
          ApiConst.updateProfile.replaceAll("<str:pk>", storage.readUid()),
          jsonData);
      print(response.statusCode);
      if (response != null) {
        Get.back();
      } else {
        print("Error");
      }
    } else {
      Get.toNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final storage = Get.put(StoreController());
    if (storage.isLogin == false) {
      Get.toNamed("/login");
    }
    return BackgroundColorDF(
        appBar: AppBar(
          backgroundColor: HexColor(ColorsConst.grey),
          foregroundColor: HexColor(ColorsConst.white),
          title: Text(
            "Edit Profile",
            style: TextStyle(
                fontFamily: GoogleFonts.inter().fontFamily,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: buttonState
                    ? () => handleEditProfile(widget.developer)
                    : null,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  foregroundColor: HexColor(ColorsConst.white),
                  backgroundColor: HexColor(ColorsConst.orange),
                  disabledBackgroundColor: HexColor(ColorsConst.grey),
                  disabledForegroundColor: HexColor(ColorsConst.grey),
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                ),
                child: const Text("Save Changes"),
              ),
            )
          ],
        ),
        body: ListView(children: [
          SizedBox(height: Get.height * 0.035),
          Center(
              child: Column(
            children: [
              Stack(children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(widget.developer.profileImage),
                ),
                Positioned(
                    bottom: 15,
                    right: 15,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: HexColor(ColorsConst.orange),
                          borderRadius: BorderRadius.circular(30)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          )),
                    ))
              ]),
              SizedBox(height: Get.height * 0.035),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Name",
                      controller: nameEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Username",
                      controller: usernameEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Email",
                      controller: emailEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Short Intro",
                      controller: shortIntroEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                      maxLines: 2,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Bio",
                      controller: bioEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                      maxLines: 5,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Location",
                      controller: locationEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Github",
                      controller: githubEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Hashnode",
                      controller: hashnodeEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Twitter",
                      controller: twitterEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "YouTube",
                      controller: youtubeEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                    TextFieldDF(
                      onChanged: (value) {
                        changeButtonState();
                      },
                      placeholder: "Website",
                      controller: websiteEditingController,
                      color: ColorsConst.white,
                      obsceureText: false,
                    ),
                    SizedBox(height: Get.height * 0.02),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ))
        ]));
  }
}
