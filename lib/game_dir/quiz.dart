import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class quiz extends StatefulWidget {
  const quiz({Key key}) : super(key: key);

  @override
  State<quiz> createState() => _quizState();
}

class _quizState extends State<quiz> {
  int answer = 1;
  var question;
  var prob1;
  var prob2;
  var prob3;
  var prob4;

  _select(int num) async {
    if (num == answer) {
      answer_dialog(context);
    } else {
      false_dialog(context);
    }
  }

  _load() async {
    setState(() {});
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
                  TextButton(onPressed: () {}, child: Text("계속 풀기")),
                  TextButton(onPressed: () {}, child: Text("그만풀기")),
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
            title: Text("오답", style: TextStyle(fontSize: 30)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            content: Container(
              width: 100,
              height: 100,
              child: Column(
                children: [
                  Text("정답은 $answer"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(onPressed: () {}, child: Text("계속 풀기")),
                      TextButton(onPressed: () {}, child: Text("그만풀기")),
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
      appBar: AppBar(title: Text("Quiz")),
      body: Column(
        children: [
          Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(15.0)),
            child: Center(
                child: Text("다음 중 국산 맥주가 아닌 것은?",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
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
                                child: Text("1번 카스",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
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
                                child: Text("2번 하이트",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
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
                                child: Text("3번 테라",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
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
                                child: Text("4번 타이거",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20))),
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
