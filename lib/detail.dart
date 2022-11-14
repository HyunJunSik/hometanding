import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hometanding/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';

class detail extends StatefulWidget {
  final int data;
  const detail(this.data);

  @override
  State<detail> createState() => _detailState();
}

//내부에서 widget.data로 접근가능
// Text("${beer[widget.data]['name']}")
class _detailState extends State<detail> {
  Icon fav = Icon(Icons.star, color: Colors.yellow);
  int num = 1;
  SharedPreferences _prefs;
  @override
  void initState() {
    // TODO: implement initState
    _load();
    super.initState();
  }

  _load() async {
    _prefs = await SharedPreferences.getInstance();
    var key = _prefs.getInt("${widget.data}") ?? -1;
    if (key == -1) {
      setState(() {
        fav = Icon(Icons.star_outline_outlined, color: Colors.yellow);
        int num = 1;
      });
    } else {
      setState(() {
        fav = Icon(Icons.star, color: Colors.yellow);
        int num = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BEER DETAIL",
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "${beer[widget.data]['image']}",
                  height: 200,
                ),
              ),
            ],
          ),
          Text("${beer[widget.data]['name']}"),
          Row(
            children: [
              Text("${beer[widget.data]['alcohol']}"),
              SizedBox(width: 20),
              Text("${beer[widget.data]['type']}"),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.purple,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0), color: Colors.blue),
              child: Row(
                children: <Widget>[
                  Text("즐겨찾기에 추가",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  IconButton(
                    onPressed: () => setState(() {
                      if (num == 0) {
                        fav = Icon(Icons.star_outline_outlined,
                            color: Colors.yellow);
                        num = 1;
                        _prefs.remove("${widget.data}");
                      } else {
                        fav = Icon(Icons.star, color: Colors.yellow);
                        num = 0;
                        _prefs.setInt("${widget.data}", widget.data);
                      }
                    }),
                    icon: fav,
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 10,
                  // strutStyle:
                  //     StrutStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  text: TextSpan(
                    text: "맥주 특징 : ${beer[widget.data]['dis']}",
                    style: TextStyle(
                        color: Colors.black, height: 2.0, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            child: Text("확인",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )),
    );
  }
}
