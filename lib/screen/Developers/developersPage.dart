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
    // print('Hello!');
    // final response =
    //     await http.get(Uri.parse('https://devfinder.xyz/user-api/profiles/'));

    // print('Hello! ' + response.body.toString());
    // if (response.statusCode == 200) {
    //   var developers = jsonDecode(response.body);
    //   return developers
    //       .map((developer) => Developer.fromJson(developer))
    //       .toList();
    // } else {
    //   throw Exception('Failed to load Developer');
    // }
    var data = """[
  {
    "name": "Rahul",
    "username": "rahul",
    "email": "rahul@google.com",
    "url": "https://google.com",
    "skills": ["Flutter", "Dart", "Python"],
    "messages_sent": ["Hello", "Hi"],
    "messages_received": ["Hello", "Hi"],
    "location": "India",
    "shortIntro": "Hello",
    "bio": "Hello",
    "profileImage": "https://google.com",
    "socialGithub": "https://github.com",
    "socialTwitter": "https://twitter.com",
    "socialYoutube": "https://youtube.com",
    "socialWebsite": "https://google.com",
    "socialHashnode": "https://google.com",
    "createdAt": "2021-08-01T00:00:00.000Z"
  },
  {
    "name": "Rahul",
    "username": "rahul",
    "email": "rahul@google.com",
    "url": "https://google.com",
    "skills": ["Flutter", "Dart", "Python"],
    "messages_sent": ["Hello", "Hi"],
    "messages_received": ["Hello", "Hi"],
    "location": "India",
    "shortIntro": "Hello",
    "bio": "Hello",
    "profileImage": "https://google.com",
    "socialGithub": "https://github.com",
    "socialTwitter": "https://twitter.com",
    "socialYoutube": "https://youtube.com",
    "socialWebsite": "https://google.com",
    "socialHashnode": "https://google.com",
    "createdAt": "2021-08-01T00:00:00.000Z"
  }
]""";
    final List<dynamic> developers = jsonDecode(data);
    return developers
        .map((developer) => Developer.fromJson(developer))
        .toList();
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
            // Handle the case when snapshot has neither error nor data
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
