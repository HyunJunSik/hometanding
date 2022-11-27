import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class random extends StatefulWidget {
  const random({Key key}) : super(key: key);

  @override
  State<random> createState() => _randomState();
}

class _randomState extends State<random> {
  int num1 = 0;
  int num2 = 0;

  _press1() async {
    setState(() {
      num1 = Random().nextInt(10) + 1;
    });
  }

  _press2() async {
    setState(() {
      num2 = Random().nextInt(10) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("지옥의 섯다"),
          backgroundColor: Color(0xFF2DA30D),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 70),
              Transform.rotate(
                angle: pi,
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 80, right: 40, top: 30, bottom: 10),
                        child: Container(
                            child: Text(num2.toString(),
                                style: TextStyle(
                                    fontSize: 30, color: Colors.green))),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                        onPressed: () {
                          _press2();
                        },
                        child: Text(
                          "누르세요!",
                          style: TextStyle(fontSize: 25, color: Colors.purple),
                        )),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Divider(
                thickness: 5,
              ),
              SizedBox(height: 30),
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.blue),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 80, right: 40, top: 30, bottom: 10),
                  child: Text(num1.toString(),
                      style: TextStyle(fontSize: 30, color: Colors.green)),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: () {
                    _press1();
                  },
                  child: Text("누르세요!",
                      style: TextStyle(fontSize: 25, color: Colors.purple))),
            ],
          ),
        ));
  }
}
