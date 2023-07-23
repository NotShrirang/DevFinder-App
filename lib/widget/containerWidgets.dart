// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:devfinder/const/iconConst.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/link.dart';
import 'package:devfinder/const/colorConst.dart';

class BackgroundColorDF extends StatelessWidget {
  Widget body, bottomNavigationBar;
  BackgroundColorDF(
      {super.key, required this.body, required this.bottomNavigationBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              HexColor(ColorsConst.gradientRed),
              HexColor(ColorsConst.gradientBlack),
              HexColor(ColorsConst.gradientBlue)
            ])),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}

class ProfileCard extends StatelessWidget {
  String name;
  String domain;
  String description;
  String twitter;
  String github;
  var image;

  ProfileCard(
      {super.key,
      required this.name,
      required this.domain,
      required this.description,
      required this.image,
      required this.twitter,
      required this.github});

  widgetImage() {
    if (image == null) {
      return AssetImage(IconConst.developerIcon);
    } else {
      return NetworkImage(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Center(
        child: Container(
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: HexColor(ColorsConst.black),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border:
                  Border.all(color: HexColor(ColorsConst.white), width: 0.4),
            ),
            child: Center(
                child: Column(
              children: [
                Stack(children: [
                  Center(
                    child: Container(
                      width: Get.width * 0.9,
                      height: Get.width * 0.2,
                      decoration: BoxDecoration(
                        color: HexColor(ColorsConst.darkGrey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        border: Border.all(
                            color: HexColor(ColorsConst.white), width: 0.4),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(Get.width * 0.03),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          border: Border.all(
                              color: HexColor(ColorsConst.white), width: 0.4),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: HexColor(ColorsConst.black),
                          backgroundImage: widgetImage(),
                        ),
                      ),
                    ),
                  ),
                ]),
                SizedBox(height: Get.height * 0.02),
                Text(name,
                    style: TextStyle(
                      color: HexColor(ColorsConst.orange),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.mulish().fontFamily,
                      fontStyle: FontStyle.italic,
                    )),
                SizedBox(height: Get.height * 0.01),
                Text(domain,
                    style: TextStyle(
                      color: HexColor(ColorsConst.lightGrey),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.mulish().fontFamily,
                    )),
                SizedBox(height: Get.height * 0.01),
                Text(description,
                    style: TextStyle(
                      color: HexColor(ColorsConst.white),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.mulish().fontFamily,
                    )),
                SizedBox(height: Get.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Link(
                        target: LinkTarget.blank,
                        uri: Uri.parse(github),
                        builder: (context, followLink) => IconButton(
                              onPressed: () => followLink!(),
                              icon: SvgPicture.asset(
                                IconConst.githubIcon,
                                width: 40,
                                height: 40,
                                color: HexColor(ColorsConst.white),
                              ),
                            )),
                    SizedBox(width: Get.width * 0.03),
                    Link(
                        target: LinkTarget.blank,
                        uri: Uri.parse(github),
                        builder: (context, followLink) => IconButton(
                            onPressed: () => followLink!(),
                            icon: SvgPicture.asset(
                              IconConst.twitterIcon,
                              width: 100,
                              height: 100,
                              color: HexColor(ColorsConst.white),
                            ))),
                  ],
                ),
                SizedBox(height: Get.height * 0.02),
              ],
            ))),
      ),
    );
  }
}

class ProjectsCard extends StatelessWidget {
  String title;
  String owner;
  var featuredImage;
  String sourceLink;

  ProjectsCard(
      {super.key,
      required this.title,
      required this.owner,
      required this.featuredImage,
      required this.sourceLink});

  imageBuilder() {
    if (featuredImage == null) {
      return AssetImage(IconConst.projectIcon);
    } else {
      return NetworkImage(featuredImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      height: Get.height * 0.5,
      child: IconButton(
        onPressed: () {},
        icon: Container(
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: HexColor(ColorsConst.black),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: HexColor(ColorsConst.white), width: 0.4),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width * 0.85,
                  height: Get.height * 0.2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageBuilder(),
                      fit: BoxFit.cover,
                    ),
                    color: HexColor(ColorsConst.darkGrey),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                        color: HexColor(ColorsConst.white), width: 0.4),
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: HexColor(ColorsConst.orange),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.mulish().fontFamily,
                      fontStyle: FontStyle.italic,
                    )),
              ),
              SizedBox(height: Get.height * 0.01),
              Text(owner,
                  style: TextStyle(
                    color: HexColor(ColorsConst.lightGrey),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.mulish().fontFamily,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
