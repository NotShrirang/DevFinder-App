// ignore_for_file: file_names

import 'dart:convert';

import 'package:devfinder/const/apiConst.dart';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/const/iconConst.dart';
import 'package:devfinder/model/projects.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
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
              children: [
                SizedBox(height: Get.height * 0.1),
                TitleText(
                  text: "Projects",
                  color: ColorsConst.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(height: Get.height * 0.03),
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
      title: e.title,
      owner: e.owner,
      featuredImage: e.featuredImage,
      sourceLink: e.sourceLink,
      description: e.description,
    );
  }
}
