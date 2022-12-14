import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hometanding/search_alcohol.dart';
import 'package:hometanding/search_snack.dart';
import 'package:hometanding/setting.dart';
import 'Favour.dart';
import 'Splash_screen.dart';
import 'data.dart';
import 'game_dir/game.dart';
import 'dart:io';

import 'main/MainPage.dart';

var todayBeer = Random().nextInt(beer.length);
void main() {
  runApp(MaterialApp(
    home: Splash(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key key}) : super(key: key);

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  int _selectedIndex = 0;
  DateTime currentBackPressTime;

  static List<Widget> pages = <Widget>[
    MainPage(todayBeer),
    favourite(),
    setting(),
  ];

  void _onitemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "메인화면"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.star,
                ),
                label: "즐겨찾기"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info,
                ),
                label: "INFO")
          ],
          currentIndex: _selectedIndex,
          onTap: _onitemTap,
        ),
      ),
      onWillPop: onWillPop,
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      const _msg = '뒤로 버튼을 한 번 더 누르시면 종료됩니다.';
      const snackBar = SnackBar(content: Text(_msg));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
