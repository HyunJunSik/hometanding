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
  int _selectedIndex = 1;

  static List<Widget> pages = <Widget>[
    favourite(),
    MainPage(todayBeer),
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
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.star,
                  ),
                  label: "즐겨찾기"),
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "메인화면"),
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
        onWillPop: () => showExitPopup(context));
  }
}

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            content: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("정말로 종료하시겠습니까?"),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        exit(0);
                      },
                      child: Text("네"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("아니요", style: TextStyle(color: Colors.black)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  )),
                ],
              ),
            ],
          ),
        ));
      });
}
