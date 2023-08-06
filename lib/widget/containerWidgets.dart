// ignore_for_file: file_names, must_be_immutable, prefer_typing_uninitialized_variables
import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/iconConst.dart';
import 'package:devfinder/controller/getStorage.dart';
import 'package:devfinder/controller/signin.dart';
import 'package:devfinder/model/developers.dart';
import 'package:devfinder/model/projects.dart';
import 'package:devfinder/screen/Developers/DevelopersPage/developersProfilePage.dart';
import 'package:devfinder/screen/MyProfile/EditProfile/editProfilePage.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/textfieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/link.dart';
import 'package:devfinder/const/colorConst.dart';

class BackgroundColorDF extends StatelessWidget {
  Widget body, bottomNavigationBar;
  PreferredSizeWidget appBar;
  BackgroundColorDF(
      {super.key,
      this.appBar = const PreferredSize(
          preferredSize: Size.fromHeight(0.0), child: SizedBox()),
      required this.body,
      this.bottomNavigationBar = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
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
  String uid;
  String name;
  String username;
  String description;
  String twitter;
  String github;
  var image;

  ProfileCard(
      {super.key,
      required this.uid,
      required this.name,
      required this.username,
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
    return MaterialButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BackgroundColorDF(
                      appBar: AppBar(
                        backgroundColor: HexColor(ColorsConst.grey),
                        foregroundColor: HexColor(ColorsConst.white),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                foregroundColor: HexColor(ColorsConst.white),
                                backgroundColor: HexColor(ColorsConst.orange),
                                disabledBackgroundColor:
                                    HexColor(ColorsConst.grey),
                                disabledForegroundColor:
                                    HexColor(ColorsConst.grey),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20.0),
                              ),
                              child: const Text("Message"),
                            ),
                          )
                        ],
                      ),
                      body: DevelopersProfilePage(
                        uid: uid,
                      ),
                    )));
      },
      // child: Padding(
      //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      //   child: Center(
      //     child: Container(
      //         width: Get.width * 0.9,
      //         decoration: BoxDecoration(
      //           color: HexColor(ColorsConst.black),
      //           borderRadius: const BorderRadius.all(Radius.circular(10)),
      //           border:
      //               Border.all(color: HexColor(ColorsConst.white), width: 0.4),
      //         ),
      //         child: Center(
      //             child: Column(
      //           children: [
      //             Stack(children: [
      //               Center(
      //                 child: Container(
      //                   width: Get.width * 0.9,
      //                   height: Get.width * 0.2,
      //                   decoration: BoxDecoration(
      //                     color: HexColor(ColorsConst.darkGrey),
      //                     borderRadius:
      //                         const BorderRadius.all(Radius.circular(5)),
      //                     border: Border.all(
      //                         color: HexColor(ColorsConst.white), width: 0.4),
      //                   ),
      //                 ),
      //               ),
      //               Center(
      //                 child: Padding(
      //                   padding: EdgeInsets.all(Get.width * 0.03),
      //                   child: Container(
      //                     decoration: BoxDecoration(
      //                       borderRadius:
      //                           const BorderRadius.all(Radius.circular(50)),
      //                       border: Border.all(
      //                           color: HexColor(ColorsConst.white), width: 0.4),
      //                     ),
      //                     child: CircleAvatar(
      //                       radius: 50,
      //                       backgroundColor: HexColor(ColorsConst.black),
      //                       backgroundImage: widgetImage(),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ]),
      //             SizedBox(height: Get.height * 0.02),
      //             Text(name,
      //                 style: TextStyle(
      //                   color: HexColor(ColorsConst.orange),
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                   fontFamily: GoogleFonts.mulish().fontFamily,
      //                   fontStyle: FontStyle.italic,
      //                 )),
      //             SizedBox(height: Get.height * 0.01),
      //             Text(domain,
      //                 style: TextStyle(
      //                   color: HexColor(ColorsConst.lightGrey),
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.bold,
      //                   fontFamily: GoogleFonts.mulish().fontFamily,
      //                 )),
      //             SizedBox(height: Get.height * 0.01),
      //             Text(description,
      //                 style: TextStyle(
      //                   color: HexColor(ColorsConst.white),
      //                   fontSize: 15,
      //                   fontWeight: FontWeight.bold,
      //                   fontFamily: GoogleFonts.mulish().fontFamily,
      //                 )),
      //             SizedBox(height: Get.height * 0.02),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Link(
      //                     target: LinkTarget.blank,
      //                     uri: Uri.parse(github),
      //                     builder: (context, followLink) => IconButton(
      //                           onPressed: () => followLink!(),
      //                           icon: SvgPicture.asset(
      //                             IconConst.githubIcon,
      //                             width: 40,
      //                             height: 40,
      //                             color: HexColor(ColorsConst.white),
      //                           ),
      //                         )),
      //                 SizedBox(width: Get.width * 0.03),
      //                 Link(
      //                     target: LinkTarget.blank,
      //                     uri: Uri.parse(github),
      //                     builder: (context, followLink) => IconButton(
      //                         onPressed: () => followLink!(),
      //                         icon: SvgPicture.asset(
      //                           IconConst.twitterIcon,
      //                           width: 100,
      //                           height: 100,
      //                           color: HexColor(ColorsConst.white),
      //                         ))),
      //               ],
      //             ),
      //             SizedBox(height: Get.height * 0.02),
      //           ],
      //         ))),
      //   ),
      // ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            Get.width * 0, 0, Get.width * 0, Get.height * 0.03),
        child: Container(
          padding: EdgeInsets.fromLTRB(Get.width * 0.02, Get.width * 0.024,
              Get.width * 0.02, Get.width * 0.024),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor(ColorsConst.darkGrey),
          ),
          child: SizedBox(
            width: Get.width * 0.8,
            height: Get.height * 0.17,
            child: Row(children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
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
                              radius: 45,
                              backgroundImage: widgetImage(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Get.height * 0.01),
                      Text(
                        username,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor(ColorsConst.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: HexColor(ColorsConst.orange),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                    Text(
                      description,
                      softWrap: true,
                      overflow: TextOverflow.fade,
                      maxLines: 5,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: HexColor(ColorsConst.white),
                      ),
                    ),
                    SizedBox(height: Get.height * 0.01),
                  ],
                ),
              ),
            ]),
          ),
        ),
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
      padding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.height * 0.01,
          Get.width * 0.05, Get.height * 0.01),
      child: Container(
        width: Get.width * 0.9,
        height: Get.height * 0.21,
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
                    height: Get.height * 0.08,
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
                    width: Get.width * 0.005,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: HexColor(ColorsConst.orange),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.06),
                  Container(
                    width: Get.width * 0.4,
                    height: Get.height * 0.08,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 2,
                            style: TextStyle(
                              color: HexColor(ColorsConst.orange),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.mulish().fontFamily,
                              fontStyle: FontStyle.italic,
                            )),
                        SizedBox(height: Get.height * 0.01),
                        Text(owner,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            style: TextStyle(
                              color: HexColor(ColorsConst.lightGrey),
                              fontSize: 12,
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
              height: Get.height * 0.001,
              decoration: BoxDecoration(color: HexColor(ColorsConst.grey)),
            ),
            Container(
              height: Get.height * 0.1244,
              padding: EdgeInsets.all(Get.width * 0.03),
              alignment: Alignment.center,
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    color: Colors.white,
                    fontSize: 12),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            )
          ],
        )),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  String uid;
  ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  dynamic displayImage;
  var skills = [];
  List<Project> projects = [];
  bool isUser = false;

  @override
  void initState() {
    super.initState();
    final storage = Get.put(StoreController());
    final loggedInUser = storage.readUid();
    if (widget.uid == loggedInUser) {
      isUser = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    dynamic getProfile() async {
      var response =
          await Api().get("${ApiConst.getAllProfiles}${widget.uid}/");
      if (response['profileImage'] == null) {
        displayImage = AssetImage(IconConst.developerIcon);
      } else {
        displayImage = NetworkImage(response['profileImage']);
      }
      skills = response['skills'];
      var developerData = Developer.fromJson(response);
      Map projectResponse = await Api().get(
          ApiConst.getCurrentUserProjects.replaceAll("<str:pk>", widget.uid));
      List projectsResults = projectResponse['results'];
      projects =
          projectsResults.map((project) => Project.fromJson(project)).toList();
      return developerData;
    }

    return FutureBuilder(
        future: getProfile(),
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
                  SizedBox(height: Get.height * 0.02),
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
                                    fontFamily: GoogleFonts.inter().fontFamily,
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
                                    fontFamily: GoogleFonts.inter().fontFamily,
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
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
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
                  if (isUser)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            margin: EdgeInsets.fromLTRB(Get.width * 0.06,
                                Get.height * 0.02, 0, Get.height * 0.02),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                              developer: developer,
                                            )));
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
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
                          margin: EdgeInsets.fromLTRB(0, Get.height * 0.02,
                              Get.width * 0.06, Get.height * 0.02),
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
                                              color: HexColor(
                                                  ColorsConst.orange))),
                                      content: Text("Are you sure?",
                                          style: TextStyle(
                                              color: HexColor(
                                                  ColorsConst.orange))),
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
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor(ColorsConst.white),
                                ),
                              )),
                        ),
                      ],
                    ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        Get.width * 0.06, 0, Get.width * 0.06, 0),
                    child: Text(
                      "Bio",
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: HexColor(ColorsConst.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(Get.width * 0.06,
                        Get.height * 0.02, Get.width * 0.06, 0),
                    child: Text(
                      developer.bio,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: HexColor(ColorsConst.white),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            Get.width * 0.06, 0, Get.width * 0.06, 0),
                        child: Text(
                          (isUser) ? "My Skills" : "Skills",
                          style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: HexColor(ColorsConst.white),
                          ),
                        ),
                      ),
                      if (isUser)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, Get.height * 0.02,
                              Get.width * 0.06, Get.height * 0.02),
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
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          side: BorderSide(
                                            color: HexColor(ColorsConst.orange),
                                          ),
                                        ),
                                        backgroundColor:
                                            HexColor(ColorsConst.black),
                                        shadowColor:
                                            HexColor(ColorsConst.orange),
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
                                                            widget.uid),
                                                    {
                                                      "name": skillController
                                                          .text
                                                          .trim()
                                                    });
                                                setState(() {
                                                  skills.add(skillController
                                                      .text
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
                  SizedBox(height: Get.height * 0.01),
                  Container(
                    margin: EdgeInsets.fromLTRB(Get.width * 0.06,
                        (isUser) ? 0 : Get.height * 0.02, Get.width * 0.06, 0),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            Get.width * 0.06,
                            (isUser) ? 0 : Get.height * 0.03,
                            Get.width * 0.06,
                            0),
                        child: Text(
                          (isUser) ? "My Projects" : "Projects",
                          style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: HexColor(ColorsConst.white),
                          ),
                        ),
                      ),
                      if (isUser)
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, Get.height * 0.02,
                              Get.width * 0.06, Get.height * 0.02),
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
                              onPressed: () {},
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
