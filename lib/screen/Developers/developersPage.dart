// ignore_for_file: file_names
import 'dart:convert';
import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:devfinder/model/developers.dart';

class DevelopersPage extends StatelessWidget {
  const DevelopersPage({super.key});

  Future<List<Developer>> fetchDeveloper() async {
    final response =
        await http.get(Uri.parse('https://devfinder.xyz/user-api/profiles/'));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
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
            print(snapshot.error);
            return Center(
              child: TitleText(
                text: snapshot.error.toString(),
                color: ColorsConst.white,
              ),
            );
          } else if (snapshot.hasData) {
            final developers = snapshot.data!;
            return Center(
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.1),
                  TitleText(
                    text: "Profiles",
                    color: ColorsConst.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Expanded(
                    child: ListView(
                      children: developers.map(buildDevelopers).toList(),
                    ),
                  ),
                ],
              ),
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
        name: e.name,
        domain: e.username,
        description: e.email,
        image: e.profileImage,
        twitter: e.socialTwitter,
        github: e.socialGithub);
  }
}
