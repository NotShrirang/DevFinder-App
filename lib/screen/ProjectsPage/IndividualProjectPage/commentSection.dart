// ignore_for_file: file_names

import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/model/comments.dart';
import 'package:devfinder/screen/Developers/DevelopersProfilePage/developersProfilePage.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class CommentSection extends StatelessWidget {
  String projectuid;
  CommentSection({super.key, required this.projectuid});

  Future<List<Comment>> getComments() async {
    final response =
        await Api().get('${ApiConst.getAllProjects}$projectuid/reviews/');
    if (response != null) {
      var jsonResponse = response;
      var data = jsonResponse['results'] as List<dynamic>;
      return data.map((comment) => Comment.fromJson(comment)).toList();
    } else {
      throw Exception('Failed to load comments.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getComments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: HexColor(ColorsConst.white),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: TitleText(
                text: snapshot.error.toString(),
                color: ColorsConst.white,
              ),
            );
          } else if (snapshot.hasData) {
            final projects = snapshot.data!;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              height: Get.height * 0.7,
              width: Get.width,
              child: Column(children: [
                Text("Comments",
                    style: TextStyle(
                        color: HexColor(ColorsConst.white), fontSize: 20),
                    textAlign: TextAlign.center),
                SizedBox(height: Get.height * 0.02),
                Expanded(
                  child: ListView(
                    children: projects
                        .map((comment) => CommentCard(
                              comment: comment,
                            ))
                        .toList(),
                  ),
                )
              ]),
            );
          } else {
            return Container();
          }
        });
  }
}

// ignore: must_be_immutable
class CommentCard extends StatelessWidget {
  Comment comment;
  CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 0.9,
      margin: EdgeInsets.symmetric(vertical: Get.height * 0.01),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MaterialButton(
                color: HexColor(ColorsConst.orange),
                padding: const EdgeInsets.all(0),
                minWidth: 0,
                shape: CircleBorder(
                  side: BorderSide(color: HexColor(ColorsConst.orange)),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BackgroundColorDF(
                                appBar: AppBar(
                                  backgroundColor: HexColor(ColorsConst.grey),
                                  foregroundColor: HexColor(ColorsConst.white),
                                  title: Text(
                                    comment.ownerName,
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  actions: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: () {},
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          foregroundColor:
                                              HexColor(ColorsConst.white),
                                          backgroundColor:
                                              HexColor(ColorsConst.orange),
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
                                  uid: comment.ownerId,
                                ),
                              )));
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      NetworkImage("${ApiConst.BASEURL}${comment.ownerImage}"),
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(comment.ownerName,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        style: TextStyle(
                          fontFamily: GoogleFonts.mulish().fontFamily,
                          fontWeight: FontWeight.normal,
                          color: HexColor(ColorsConst.white),
                          fontSize: 12,
                        )),
                    SizedBox(height: Get.height * 0.007),
                    Container(
                      decoration: BoxDecoration(
                          color: HexColor(ColorsConst.black),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(comment.body,
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: GoogleFonts.mulish().fontFamily,
                            fontWeight: FontWeight.normal,
                            color: HexColor(ColorsConst.white),
                            fontSize: 16,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
