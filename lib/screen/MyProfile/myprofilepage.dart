import 'package:devfinder/controller/getStorage.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final storage = Get.put(StoreController());
    final uid = storage.readUid();
    return ProfilePage(uid: uid);
  }
}
