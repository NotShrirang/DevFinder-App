import 'package:devfinder/const/colorConst.dart';
import 'package:devfinder/screen/Home/homePage.dart';
import 'package:devfinder/screen/Developers/developersPage.dart';
import 'package:devfinder/screen/Projects/projectsPage.dart';
import 'package:devfinder/screen/Login/loginPage.dart';
import 'package:devfinder/widget/containerWidgets.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevFinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DevFinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DevelopersPage(),
    ProjectsPage(),
    LoginPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundColorDF(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                label: "",
                icon: const Icon(Icons.home_filled),
                backgroundColor: HexColor(ColorsConst.black)),
            BottomNavigationBarItem(
                label: "",
                icon: const Icon(Icons.people_outline),
                backgroundColor: HexColor(ColorsConst.black)),
            BottomNavigationBarItem(
                label: "",
                icon: const Icon(Icons.code_outlined),
                backgroundColor: HexColor(ColorsConst.black)),
            BottomNavigationBarItem(
                label: "",
                icon: const Icon(Icons.login_outlined),
                backgroundColor: HexColor(ColorsConst.black)),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: HexColor(ColorsConst.orange),
          unselectedItemColor: Colors.black,
          selectedFontSize: 0,
          selectedIconTheme:
              IconThemeData(color: HexColor(ColorsConst.orange), size: 30),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, size: 30),
          iconSize: 40,
          onTap: _onItemTapped,
          elevation: 5,
          backgroundColor: HexColor(ColorsConst.black)),
    );
  }
}
