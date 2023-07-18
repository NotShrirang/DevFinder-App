// ignore_for_file: file_names

import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/const/iconConst.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          TitleText(text: 'Projects', color: ColorsConst.white),
          SizedBox(
            height: Get.height * 0.02,
          ),
          ProjectsCard(
              name: "Indian Sign Language Recognition using Transfer Learning",
              domain: "AI/ML",
              description: "ABCD",
              image: SvgAssetLoader(IconConst.githubIcon),
              github: "https://www.google.com")
        ],
      )),
    );
  }
}
