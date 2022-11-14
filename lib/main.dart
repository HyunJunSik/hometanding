import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hometanding/search_alcohol.dart';
import 'package:hometanding/search_snack.dart';
import 'MainPage.dart';
import 'Splash_screen.dart';
import 'data.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  static List<Widget> pages = <Widget>[
    MainPage(),
    Alcohol(),
    search_snack(),
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
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '알콜사전'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '안주사전'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onitemTap,
      ),
    );
  }
}
