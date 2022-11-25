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
            child: InkWell(
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: Text("roulette")),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Roulette()));
                }),
          ),
          Flexible(
            child: InkWell(
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: Text("random number")),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => random()));
                }),
          ),
          Flexible(
            child: InkWell(
                child: Container(
                  color: Colors.transparent,
                  child: Center(child: Text("quiz")),
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => quiz()));
                }),
          ),
        ],
      ),
    );
  }
}
