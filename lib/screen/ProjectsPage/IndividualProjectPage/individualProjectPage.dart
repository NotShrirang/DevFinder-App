// ignore_for_file: file_names, must_be_immutable

import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/const/iconConst.dart';
import 'package:devfinder/model/developers.dart';
import 'package:devfinder/model/projects.dart';
import 'package:devfinder/screen/ProjectsPage/IndividualProjectPage/commentSection.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/link.dart';

class IndividualProjectCard extends StatefulWidget {
  Project project;
  IndividualProjectCard({super.key, required this.project});

  @override
  State<IndividualProjectCard> createState() => _IndividualProjectCardState();
}

class _IndividualProjectCardState extends State<IndividualProjectCard> {
  var displayImage;

  late Developer developer;
  late String projectUid;
  var tags = [];

  BottomDrawerController _controller = BottomDrawerController();
  String _button = 'None';
  double _headerHeight = Get.height * 0.1;
  double _bodyHeight = Get.height * 0.9;
  TextEditingController _commentController = TextEditingController();

  imageBuilder() {
    if (widget.project.featuredImage == null) {
      return AssetImage(IconConst.projectIcon);
    } else {
      return NetworkImage(widget.project.featuredImage);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<Developer> fetchDeveloper() async {
    var response =
        await Api().get("${ApiConst.getAllProfiles}${widget.project.owner}/");
    var developerData = Developer.fromJson(response);
    developer = developerData;
    projectUid = widget.project.url.split("/")[5];
    tags = widget.project.tags;
    return developerData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchDeveloper(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: HexColor(ColorsConst.white),
              ),
            );
          } else if (snapshot.hasError) {
            // print(snapshot.error);
            return Center(
              child: TitleText(
                text: snapshot.error.toString(),
                color: ColorsConst.white,
              ),
            );
          } else if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding:
                                EdgeInsets.fromLTRB(0, 0, 0, Get.height * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: Get.height * 0.25,
                                      width: Get.width,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.5),
                                              BlendMode.darken),
                                          image: imageBuilder(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: Get.height * 0.01,
                                      left: Get.width * 0.03,
                                      width: Get.width * 0.7,
                                      child: Text(
                                        widget.project.title,
                                        style: TextStyle(
                                            color: HexColor(ColorsConst.white),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 35),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Developer",
                                      style: TextStyle(
                                          color: HexColor(ColorsConst.orange),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: Get.height * 0.01),
                                    ProfileCard(
                                      uid: widget.project.owner,
                                      name: developer.name,
                                      username: developer.username,
                                      description: developer.bio,
                                      image: developer.profileImage,
                                      twitter: developer.socialTwitter,
                                      github: developer.socialGithub,
                                    )
                                  ],
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Link(
                                  target: LinkTarget.blank,
                                  uri: Uri.parse(widget.project.demoLink),
                                  builder: (context, followLink) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: HexColor(ColorsConst.white),
                                            width: 0.4),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerRight,
                                            end: Alignment.centerLeft,
                                            colors: [
                                              HexColor(ColorsConst.gradientRed),
                                              HexColor(
                                                  ColorsConst.gradientBlack),
                                              HexColor(ColorsConst.gradientBlue)
                                            ])),
                                    child: TextButton(
                                        onPressed: () => followLink!(),
                                        style: ButtonStyle(
                                            splashFactory:
                                                NoSplash.splashFactory,
                                            surfaceTintColor:
                                                MaterialStateProperty.all(
                                                    Colors.transparent)),
                                        child: Text(
                                          "View Source",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color:
                                                  HexColor(ColorsConst.white),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Container(
                                  height: Get.height * 0.002,
                                  width: Get.width,
                                  color: HexColor(ColorsConst.orange),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Text(
                                  "About Project",
                                  style: TextStyle(
                                      color: HexColor(ColorsConst.orange),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Text(
                                    widget.project.description,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: HexColor(ColorsConst.white),
                                        fontSize: 20),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Container(
                                  height: Get.height * 0.002,
                                  width: Get.width,
                                  color: HexColor(ColorsConst.orange),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Text(
                                  "Tags",
                                  style: TextStyle(
                                      color: HexColor(ColorsConst.orange),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: Get.height * 0.02),
                                SizedBox(
                                  height: Get.height * 0.05,
                                  width: Get.width,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tags.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.02),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.02),
                                          decoration: BoxDecoration(
                                              color: HexColor(ColorsConst.grey),
                                              border: Border.all(
                                                  color: HexColor(
                                                      ColorsConst.orange),
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Center(
                                            child: Text(
                                              tags[index]['name'],
                                              style: TextStyle(
                                                  color: HexColor(
                                                      ColorsConst.white),
                                                  fontSize: 15),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(height: Get.height * 0.1),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                _buildBottomDrawer(context),
              ],
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: HexColor(ColorsConst.white),
            ));
          }
        });
  }

  Widget _buildBottomDrawer(BuildContext context) {
    return BottomDrawer(
      header: _buildBottomDrawerHead(context),
      body: _buildBottomDrawerBody(context),
      headerHeight: _headerHeight,
      drawerHeight: _bodyHeight,
      cornerRadius: 20.0,
      color: HexColor(ColorsConst.black),
      controller: _controller,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          blurRadius: 60,
          spreadRadius: 5,
          offset: const Offset(2, -6),
        ),
      ],
    );
  }

  Widget _buildBottomDrawerHead(BuildContext context) {
    return Container(
      height: _headerHeight,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10.0,
              right: 10.0,
              top: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 5.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Get.height * 0.08,
              width: Get.width,
              decoration: BoxDecoration(
                  color: HexColor(ColorsConst.black),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyIconButton(
                    onPressed: () {},
                    onTapColor: HexColor(ColorsConst.orange),
                    size: 28,
                    icon: Icons.favorite,
                  ),
                  IconButton(
                    onPressed: () {
                      _controller.open();
                    },
                    style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(Get.width * 0.02))),
                    icon: Icon(Icons.mode_comment_outlined,
                        size: 28, color: HexColor(ColorsConst.white)),
                  ),
                  IconButton(
                    key: UniqueKey(),
                    onPressed: () {
                      Share.share(
                          "Checkout this project on DevFinder: ${widget.project.title} \n https://dev-finder-5b30d7.netlify.app/projects/project/${widget.project.url.split("/")[5]}");
                    },
                    style: ButtonStyle(
                        splashFactory: NoSplash.splashFactory,
                        padding: MaterialStateProperty.all(
                            EdgeInsets.all(Get.width * 0.02))),
                    icon: Icon(
                      Icons.share_outlined,
                      size: 28,
                      color: HexColor(ColorsConst.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1.0,
            color: HexColor(ColorsConst.lightGrey),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomDrawerBody(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.05, vertical: Get.height * 0.02),
                child: TextField(
                  controller: _commentController,
                  style: TextStyle(color: HexColor(ColorsConst.white)),
                  decoration: InputDecoration(
                    hintText: "Add a comment",
                    hintStyle: TextStyle(color: HexColor(ColorsConst.white)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        addComment();
                        _commentController.clear();
                        _controller.open();
                      },
                      icon: Icon(
                        Icons.send,
                        color: HexColor(ColorsConst.white),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor(ColorsConst.white)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor(ColorsConst.white)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor(ColorsConst.white)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(child: CommentSection(projectuid: projectUid)),
            ],
          ),
        ],
      ),
    );
  }

  Future addComment() async {
    var response = await Api().post(
        "${ApiConst.getAllProjects}$projectUid/reviews/create/",
        {"body": _commentController.text.trim()});
    if (response != null) {
      setState(() {
        _commentController.clear();
        _controller.open();
      });
    } else {
      throw Exception('Failed to add comment.');
    }
  }
}
