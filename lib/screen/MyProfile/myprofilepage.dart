import 'dart:convert';

import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/const/iconConst.dart';
import 'package:devfinder/controller/getStorage.dart';
import 'package:devfinder/controller/signin.dart';
import 'package:devfinder/model/developers.dart';
import 'package:devfinder/model/projects.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textfieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  dynamic displayImage;
  var skills = [];
  List<Project> projects = [];

  @override
  Widget build(BuildContext context) {
    dynamic getMyProfile() async {
      final storage = Get.put(StoreController());
      var response =
          await Api().get("${ApiConst.getAllProfiles}${storage.readUid()}/");
      if (response['profileImage'] == null) {
        displayImage = AssetImage(IconConst.developerIcon);
      } else {
        displayImage = NetworkImage(response['profileImage']);
      }
      skills = response['skills'];
      var developerData = Developer.fromJson(response);
      Map projectResponse = await Api().get(ApiConst.getCurrentUserProjects
          .replaceAll("<str:pk>", storage.readUid()));
      List projectsResults = projectResponse['results'];
      projects =
          projectsResults.map((project) => Project.fromJson(project)).toList();
      return developerData;
    }

    return FutureBuilder(
        future: getMyProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return BackgroundColorDF(
              body: ListView(children: [
                SizedBox(height: Get.height * 0.5),
                const Center(
                  child: CircularProgressIndicator(),
                )
              ]),
            );
          } else if (snapshot.hasError) {
            return BackgroundColorDF(
              body: Column(children: [
                SizedBox(height: Get.height * 0.5),
                const Center(
                  child: CircularProgressIndicator(),
                )
              ]),
            );
          } else {
            Developer developer = snapshot.data! as Developer;
            return BackgroundColorDF(
              body: ListView(
                children: [
                  SizedBox(height: Get.height * 0.05),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0, Get.width * 0.02, 0, Get.width * 0.02),
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.fromLTRB(Get.width * 0.06, 0, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    HexColor(ColorsConst.orange),
                                    HexColor(ColorsConst.black),
                                  ]),
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 65,
                                  backgroundImage: displayImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                Get.width * 0.06,
                                Get.height * 0.02,
                                Get.width * 0.06,
                                Get.height * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  developer.username,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor(ColorsConst.white),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                                Text(
                                  developer.shortIntro,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.normal,
                                    color: HexColor(ColorsConst.orange),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.01),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: HexColor(ColorsConst.orange),
                                    ),
                                    Text(
                                      developer.location,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: HexColor(ColorsConst.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          width: Get.width * 0.55,
                          // height: Get.height * 0.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  HexColor(ColorsConst.orange),
                                  HexColor(ColorsConst.red),
                                ]),
                          ),
                          margin: EdgeInsets.fromLTRB(
                              Get.width * 0.06,
                              Get.height * 0.02,
                              Get.width * 0.03,
                              Get.height * 0.02),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed('/editProfile');
                            },
                            child: Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: HexColor(ColorsConst.white),
                              ),
                            ),
                          )),
                      Container(
                        width: Get.width * 0.3,
                        // height: Get.height * 0.05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                HexColor(ColorsConst.orange),
                                HexColor(ColorsConst.red),
                              ]),
                        ),
                        margin: EdgeInsets.fromLTRB(
                            Get.width * 0.01,
                            Get.height * 0.02,
                            Get.width * 0.03,
                            Get.height * 0.02),
                        child: TextButton.icon(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 20,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      side: BorderSide(
                                        color: HexColor(ColorsConst.orange),
                                      ),
                                    ),
                                    shadowColor: HexColor(ColorsConst.orange),
                                    backgroundColor:
                                        HexColor(ColorsConst.black),
                                    title: Text("Sign Out",
                                        style: TextStyle(
                                            color:
                                                HexColor(ColorsConst.orange))),
                                    content: Text("Are you sure?",
                                        style: TextStyle(
                                            color:
                                                HexColor(ColorsConst.orange))),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text("No",
                                            style: TextStyle(
                                                color: HexColor(
                                                    ColorsConst.orange))),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          final storage =
                                              Get.put(MyController());
                                          await storage.signOut();
                                          Get.offAllNamed('/');
                                        },
                                        child: Text("Yes",
                                            style: TextStyle(
                                                color: HexColor(
                                                    ColorsConst.orange))),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Icons.output_outlined,
                              color: HexColor(ColorsConst.white),
                            ),
                            label: Text(
                              "Sign Out",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: HexColor(ColorsConst.white),
                              ),
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(Get.width * 0.06,
                        Get.width * 0.06, Get.width * 0.06, Get.width * 0.06),
                    child: Text(
                      developer.bio,
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor(ColorsConst.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            Get.width * 0.06, 0, Get.width * 0.06, 0),
                        child: Text(
                          "My Skills",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: HexColor(ColorsConst.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Get.width * 0.479,
                            Get.width * 0.05,
                            Get.width * 0.06,
                            Get.width * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  HexColor(ColorsConst.orange),
                                  HexColor(ColorsConst.red),
                                ]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    TextEditingController skillController =
                                        TextEditingController();
                                    return AlertDialog(
                                      elevation: 20,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(
                                          color: HexColor(ColorsConst.orange),
                                        ),
                                      ),
                                      backgroundColor:
                                          HexColor(ColorsConst.black),
                                      shadowColor: HexColor(ColorsConst.orange),
                                      scrollable: true,
                                      title: Text(
                                        'Add Skill',
                                        style: TextStyle(
                                            color:
                                                HexColor(ColorsConst.orange)),
                                      ),
                                      content: Form(
                                        child: Column(
                                          children: <Widget>[
                                            MyTextField(
                                              controller: skillController,
                                              placeholder: "Add new skill...",
                                              color: ColorsConst.white,
                                              obsceureText: false,
                                            )
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                            child: Text("Cancel",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        ColorsConst.orange))),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        TextButton(
                                            child: Text("Submit",
                                                style: TextStyle(
                                                    color: HexColor(
                                                        ColorsConst.orange))),
                                            onPressed: () {
                                              final storage =
                                                  Get.put(StoreController());
                                              var response = Api().post(
                                                  ApiConst.createSkill
                                                      .replaceAll("<str:pk>",
                                                          storage.readUid()),
                                                  {
                                                    "name": skillController.text
                                                        .trim()
                                                  });
                                              setState(() {
                                                skills.add(skillController.text
                                                    .trim());
                                              });
                                              Get.snackbar('Success!',
                                                  'Added Skill : ${skillController.text.trim()}',
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  backgroundColor: HexColor(
                                                      ColorsConst.darkGrey),
                                                  colorText: HexColor(
                                                      ColorsConst.white));
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.add,
                              color: HexColor(ColorsConst.white),
                              size: 30,
                            ),
                            alignment: Alignment.center,
                            color: HexColor(ColorsConst.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        Get.width * 0.06, 0, Get.width * 0.06, 0),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: developer.skills
                          .map(
                            (skill) => Container(
                              decoration: BoxDecoration(
                                color: HexColor(ColorsConst.darkGrey),
                                border: Border.all(
                                  color: HexColor(ColorsConst.orange),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                skill,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor(ColorsConst.white),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            Get.width * 0.06, 0, Get.width * 0.06, 0),
                        child: Text(
                          "My Projects",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: HexColor(ColorsConst.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            Get.width * 0.41,
                            Get.width * 0.05,
                            Get.width * 0.06,
                            Get.width * 0.05),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  HexColor(ColorsConst.orange),
                                  HexColor(ColorsConst.red),
                                ]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            onPressed: () {
                              Get.toNamed('/editProjects');
                            },
                            icon: Icon(
                              Icons.add,
                              color: HexColor(ColorsConst.white),
                              size: 30,
                            ),
                            alignment: Alignment.center,
                            color: HexColor(ColorsConst.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: projects.map((e) => loadProjects(e)).toList(),
                  ),
                ],
              ),
            );
          }
        });
  }

  Widget loadProjects(Project e) {
    return ProjectsCard(
        title: e.title,
        owner: e.owner,
        featuredImage: e.featuredImage,
        sourceLink: e.sourceLink,
        description: e.description);
  }
}
