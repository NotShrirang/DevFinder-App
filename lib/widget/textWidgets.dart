// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// ignore: must_be_immutable
class TitleText extends StatelessWidget {
  String text;
  String color;
  double fontSize;
  var fontFamily;
  var fontWeight;
  var textAlign;
  var typewriter;

  TitleText({
    super.key,
    required this.text,
    required this.color,
    this.fontSize = 32,
    this.fontFamily = "Roboto",
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.typewriter,
  });

  @override
  Widget build(BuildContext context) {
    if (typewriter == null) {
      return Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
            color: HexColor(color),
            fontSize: fontSize,
            fontFamily: fontFamily,
            fontWeight: fontWeight),
      );
    } else {
      return AnimatedTextKit(
        animatedTexts: [
          TyperAnimatedText(
            text,
            textStyle: TextStyle(
                color: HexColor(color),
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight),
            textAlign: textAlign,
            speed: const Duration(milliseconds: 400),
          )
        ],
        totalRepeatCount: 4,
        pause: const Duration(milliseconds: 2000),
        displayFullTextOnTap: true,
        stopPauseOnTap: true,
        repeatForever: true,
      );
    }
  }
}
