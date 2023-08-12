import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/screen/MyProfile/myprofilepage.dart';
import 'package:devfinder/screen/WelcomePage/welcomePage.dart';
import 'package:devfinder/screen/Login/loginPage.dart';
import 'package:devfinder/utils/apiCall.dart';
import 'package:devfinder/utils/root.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hexcolor/hexcolor.dart';
import 'screen/HomePage/homePage.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// Future<Widget> displayWidget() async {
//   if (await getTokenFromStorage() == null) {
//     return const WelcomePage();
//   } else {
//     return const MyHomePage(title: 'DevFinder');
//   }
// }

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DevFinder',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const Root(),
      routes: {
        '/home': (context) => const MyHomePage(title: 'DevFinder'),
        '/login': (context) => const LoginPage(),
      },
    );
  }
}
