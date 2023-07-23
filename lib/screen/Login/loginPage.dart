// ignore_for_file: file_names

import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/const/iconConst.dart';
import 'package:devfinder/screen/Home/homePage.dart';
import 'package:devfinder/widget/textWidgets.dart';
import 'package:devfinder/widget/textfieldWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: Get.height * 0.1,
        ),
        TitleText(
          text: 'Log In',
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: ColorsConst.white,
        ),
        SizedBox(
          height: Get.height * 0.05,
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
          child: MyTextField(
            controller: TextEditingController(),
            placeholder: 'Enter your username',
            color: ColorsConst.white,
          ),
        ),
        SizedBox(
          height: Get.width * 0.05,
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(Get.width * 0.07, 0, Get.width * 0.07, 0),
          child: MyTextField(
            controller: TextEditingController(),
            placeholder: 'Enter your password',
            color: ColorsConst.white,
          ),
        ),
        SizedBox(
          height: Get.width * 0.05,
        ),
        TextButton(
            onPressed: () {},
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                  color: HexColor(ColorsConst.orange),
                  decoration: TextDecoration.underline,
                  fontSize: 15),
            )),
        SizedBox(
          height: Get.width * 0.05,
        ),
        Container(
          width: Get.width * 0.6,
          height: Get.height * 0.08,
          decoration: BoxDecoration(
            border: Border.all(color: HexColor(ColorsConst.white), width: 0.4),
            borderRadius: BorderRadius.circular(30),
            color: HexColor(ColorsConst.orange),
          ),
          child: TextButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                elevation: MaterialStateProperty.all<double>(50),
                overlayColor: MaterialStateProperty.all<Color>(
                    HexColor(ColorsConst.orange)),
              ),
              child: Text(
                'SIGN IN',
                style: TextStyle(
                    color: HexColor(ColorsConst.white),
                    fontSize: 15,
                    fontFamily: GoogleFonts.mulish().fontFamily,
                    fontWeight: FontWeight.bold),
              )),
        ),
        SizedBox(
          height: Get.width * 0.05,
        ),
        Text("-- OR --",
            style: TextStyle(
                color: HexColor(ColorsConst.white),
                fontSize: 15,
                fontFamily: GoogleFonts.mulish().fontFamily,
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: Get.width * 0.05,
        ),
        Container(
          width: Get.width * 0.7,
          height: Get.height * 0.08,
          decoration: BoxDecoration(
            border: Border.all(color: HexColor(ColorsConst.white), width: 0.4),
            borderRadius: BorderRadius.circular(10),
            color: HexColor(ColorsConst.darkGrey),
          ),
          child: Row(
            children: [
              SizedBox(
                width: Get.width * 0.05,
              ),
              SvgPicture.asset(
                IconConst.googleIcon,
                width: Get.width * 0.1,
                height: Get.width * 0.1,
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
              Text(
                'Sign in with Google',
                style: TextStyle(
                    color: HexColor(ColorsConst.white),
                    fontSize: 15,
                    fontFamily: GoogleFonts.mulish().fontFamily,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: Get.width * 0.05,
              ),
            ],
          ),
        )
      ],
    ));
  }
}
