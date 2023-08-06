// ignore_for_file: file_names
import 'dart:convert';
import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:devfinder/model/developers.dart';

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({super.key});

  Future<List<Developer>> fetchDeveloper() async {
    final response = await Api().get(ApiConst.getAllProfiles);
    if (response != null) {
      var jsonResponse = response;
      var data = jsonResponse['results'] as List<dynamic>;
      return data.map((developer) => Developer.fromJson(developer)).toList();
    } else {
      throw Exception('Failed to load Developer');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Developer>>(
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
            final developers = snapshot.data!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.035),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                      vertical: Get.height * 0.01),
                  child: TitleText(
                    text: "Developers",
                    color: ColorsConst.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                    fontFamily: GoogleFonts.outfit().fontFamily,
                  ),
                ),
                SizedBox(height: Get.height * 0.03),
                Expanded(
                  child: ListView(
                    children: developers.map(buildDevelopers).toList(),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: TitleText(
                text: "No developers found",
                color: ColorsConst.white,
              ),
            );
          }
        });
  }

  Widget buildDevelopers(Developer e) {
    return ProfileCard(
        uid: e.url.split("/")[5],
        name: e.name,
        username: e.username,
        description: e.bio,
        image: e.profileImage,
        twitter: e.socialTwitter,
        github: e.socialGithub);
  }
}
