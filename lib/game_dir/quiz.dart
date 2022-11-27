import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

import 'gamedata.dart';
import 'minigame.dart';

class quiz extends StatefulWidget {
  const quiz({Key key}) : super(key: key);

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  int answer;
  var question;
  var prob1;
  var prob2;
  var prob3;
  var prob4;
  _select(int num) async {
    if (num == answer || answer == 0) {
      answer_dialog(context);
    } else {
      false_dialog(context);
    }
  }

  _load() async {
    var q = Random().nextInt(quest.length);
    setState(() {
      question = quest[q]['problem'];
      prob1 = quest[q]['prob1'];
      prob2 = quest[q]['prob2'];
      prob3 = quest[q]['prob3'];
      prob4 = quest[q]['prob4'];
      answer = quest[q]['answer'];
    });
  }

  @override
  void initState() {
    _load();
    super.initState();
  }

  void answer_dialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("정답!", style: TextStyle(fontSize: 30)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _load();
                        Navigator.of(context).pop();
                      },
                      child: Text("계속 풀기"),
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
                    child: Text("그만풀기", style: TextStyle(color: Colors.black)),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  )),
                ],
              ));
        });
  }

  void false_dialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("땡! 오답입니당", style: TextStyle(fontSize: 25)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              width: 100,
              height: 80,
              child: Column(
                children: [
                  Text("정답은 $answer번 입니다!",
                      style:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            _load();
                            Navigator.of(context).pop();
                          },
                          child: Text("계속 풀기"),
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
                        child:
                            Text("그만풀기", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white),
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알콜 골든벨!"),
        backgroundColor: Color(0xFF2DA30D),
      ),
      body: Column(
        children: [
          SizedBox(height: 40),
          Container(
            height: 150,
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15.0)),
            child: Center(
                child: Text(question,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic))),
          ),
          Divider(
            thickness: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 30),
                  Row(
                    children: [
                      InkWell(
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                                child: Text(prob1,
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))),
                          ),
                          onTap: () {
                            _select(1);
                          }),
                      SizedBox(width: 30),
                      InkWell(
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                                child: Text(prob2,
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))),
                          ),
                          onTap: () {
                            _select(2);
                          }),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      InkWell(
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                                child: Text(prob3,
                                    style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))),
                          ),
                          onTap: () {
                            _select(3);
                          }),
                      SizedBox(width: 30),
                      InkWell(
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                                child: Text(prob4,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15))),
                          ),
                          onTap: () {
                            _select(4);
                          }),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
