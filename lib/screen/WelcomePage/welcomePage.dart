// ignore_for_file: file_names

import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundColorDF(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.15),
            TitleText(
              text: "DEVFINDER",
              color: ColorsConst.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: Get.height * 0.1),
            Padding(
              padding: EdgeInsets.only(
                  top: Get.height * 0.05,
                  left: Get.width * 0.1,
                  right: Get.width * 0.1),
              child: TitleText(
                text: "Empowering developers to",
                color: ColorsConst.white,
                fontSize: 21.196,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.mulish().fontFamily,
                textAlign: TextAlign.center,
                typewriter: null,
              ),
            ),
            TitleText(
              text: "Network",
              color: ColorsConst.orange,
              fontSize: 21.196,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.mulish().fontFamily,
              textAlign: TextAlign.center,
              typewriter: true,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: Get.height * 0.05,
                  left: Get.width * 0.1,
                  right: Get.width * 0.1),
              child: TitleText(
                text: "with our developer-focused social platform",
                color: ColorsConst.white,
                fontSize: 21.196,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.mulish().fontFamily,
                textAlign: TextAlign.center,
                typewriter: null,
              ),
            ),
            SizedBox(height: Get.height * 0.25),
            Container(
              width: Get.width * 0.8,
              height: Get.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: HexColor(ColorsConst.white), width: 0.4),
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        HexColor(ColorsConst.gradientRed),
                        HexColor(ColorsConst.gradientBlack),
                        HexColor(ColorsConst.gradientBlue)
                      ])),
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  elevation: MaterialStateProperty.all<double>(50),
                  overlayColor: MaterialStateProperty.all<Color>(
                      HexColor(ColorsConst.orange)),
                ),
                onPressed: () {
                  Get.toNamed('/login');
                },
                child: TitleText(
                  text: "Get Started",
                  color: ColorsConst.white,
                  fontSize: 21.196,
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.mulish().fontFamily,
                  textAlign: TextAlign.center,
                  typewriter: null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
