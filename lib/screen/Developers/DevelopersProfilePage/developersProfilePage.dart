// ignore_for_file: must_be_immutable, file_names
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:flutter/material.dart';

class DevelopersProfilePage extends StatelessWidget {
  String uid;
  DevelopersProfilePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return ProfilePage(uid: uid);
  }
}
