import 'package:flutter/material.dart';

import 'game.dart';

class game extends StatelessWidget {
  const game({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2DA30D),
        title: Text("Game"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextButton(
              child: Text("룰렛"),
              onPressed: () {
                Roulette();
              },
            ),
            TextButton(
              child: Text("지옥의 섯다"),
              onPressed: () {},
            ),
            TextButton(
              child: Text("알콜 골든벨"),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
