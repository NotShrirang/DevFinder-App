// ignore_for_file: file_names

import 'package:devfinder/const/colorConst.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  TextEditingController controller;
  String placeholder;
  String color;

  MyTextField(
      {super.key,
      required this.controller,
      required this.placeholder,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: placeholder,
        fillColor: HexColor(ColorsConst.darkGrey),
        filled: true,
        hintStyle: TextStyle(color: HexColor(ColorsConst.white)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
