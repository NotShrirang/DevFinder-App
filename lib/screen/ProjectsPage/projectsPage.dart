// ignore_for_file: file_names

import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/model/projects.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  Future<List<Project>> fetchDeveloper() async {
    final response = await Api().get(ApiConst.getAllProjects);
    if (response != null) {
      var jsonResponse = response;
      var data = jsonResponse['results'] as List<dynamic>;
      return data.map((project) => Project.fromJson(project)).toList();
    } else {
      throw Exception('Failed to load project.');
    }
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
          final projects = snapshot.data!;
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Get.height * 0.035),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.05,
                      vertical: Get.height * 0.01),
                  child: TitleText(
                    text: "Projects",
                    fontFamily: GoogleFonts.outfit().fontFamily,
                    color: ColorsConst.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: Get.height * 0.035),
                Expanded(
                  child: ListView(
                    children: projects.map(buildProjects).toList(),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: TitleText(
              text: "No projects found",
              color: ColorsConst.white,
            ),
          );
        }
      },
    );
  }

  Widget buildProjects(Project e) {
    return ProjectsCard(
      project: e,
    );
  }
}
