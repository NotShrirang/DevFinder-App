import 'package:devfinder/controller/getStorage.dart';
import 'package:devfinder/screen/HomePage/homePage.dart';
import 'package:devfinder/screen/WelcomePage/welcomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(
      init: StoreController(),
      initState: (_) {},
      builder: (_) {
        return _.isLogin == true
            ? const MyHomePage(
                title: 'DevFinder',
              )
            : const WelcomePage();
      },
    );
  }
}
