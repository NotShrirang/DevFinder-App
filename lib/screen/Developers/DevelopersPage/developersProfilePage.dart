// ignore_for_file: must_be_immutable, file_names
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:flutter/material.dart';

class DevelopersProfilePage extends StatefulWidget {
  String uid;
  DevelopersProfilePage({super.key, required this.uid});

  @override
  State<DevelopersProfilePage> createState() => _DevelopersProfilePageState();
}

class _DevelopersProfilePageState extends State<DevelopersProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ProfilePage(uid: widget.uid);
  }
}
