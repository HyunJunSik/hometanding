import 'package:flutter/material.dart';
import 'package:hometanding/game_dir/quiz.dart';
import 'package:hometanding/game_dir/random.dart';

import 'game.dart';

class game extends StatelessWidget {
  const game({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("술 게임"),
        backgroundColor: Color(0xFF2DA30D),
      ),
      body: Column(
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: InkWell(
                  child: Container(
                    color: Colors.yellow,
                    child: Center(
                        child: Text("룰렛게임!",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.bold))),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Roulette()));
                  }),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: InkWell(
                  child: Container(
                    color: Colors.greenAccent,
                    child: Center(
                        child: Text("지옥의 섯다",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.bold))),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => random()));
                  }),
            ),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: InkWell(
                  child: Container(
                    color: Colors.orangeAccent,
                    child: Center(
                        child: Text("알콜 골든벨!",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.green,
                                fontWeight: FontWeight.bold))),
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => quiz()));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
