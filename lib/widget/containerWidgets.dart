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
      {super.key,
      required this.body,
      this.bottomNavigationBar = const SizedBox()});

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
  String description;
  String owner;
  var featuredImage;
  String sourceLink;

  ProjectsCard(
      {super.key,
      required this.title,
      required this.owner,
      required this.featuredImage,
      required this.sourceLink,
      required this.description});

  imageBuilder() {
    if (featuredImage == null) {
      return AssetImage(IconConst.projectIcon);
    } else {
      return NetworkImage(featuredImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Get.width * 0.03),
      child: Container(
        width: Get.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor(ColorsConst.darkGrey)),
        child: Center(
            child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Row(
                children: [
                  Container(
                    width: Get.width * 0.4,
                    height: Get.height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageBuilder(),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(10)),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.007,
                    height: Get.height * 0.2,
                    decoration: BoxDecoration(
                      color: HexColor(ColorsConst.orange),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.06),
                  Container(
                    width: Get.width * 0.4,
                    height: Get.height * 0.2,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              color: HexColor(ColorsConst.orange),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.mulish().fontFamily,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(height: Get.height * 0.01),
                        Text(owner,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              color: HexColor(ColorsConst.lightGrey),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.mulish().fontFamily,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Get.height * 0.002,
              decoration: BoxDecoration(color: HexColor(ColorsConst.grey)),
            ),
            Container(
              height: Get.height * 0.2,
              padding: EdgeInsets.all(Get.width * 0.03),
              alignment: Alignment.center,
              child: Text(description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white)),
            )
          ],
        )),
      ),
    );
  }
}
