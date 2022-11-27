import 'package:flutter/material.dart';
import 'package:hometanding/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data.dart';

class snack_detail extends StatefulWidget {
  final int data;
  const snack_detail(this.data);

  @override
  State<snack_detail> createState() => _snack_detailState();
}

class _snack_detailState extends State<snack_detail> {
  Icon fav = Icon(Icons.star, color: Colors.yellow);
  int num = 1;
  int mat;
  int process_length;
  SharedPreferences _prefs;
  @override
  void initState() {
    // TODO: implement initState
    _load();
    super.initState();
  }

  _load() async {
    mat = food[widget.data]['material'].length;
    process_length = food[widget.data]['how'].length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 200,
                  ),
                  child: Image.asset(
                    "${food[widget.data]['image']}",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${food[widget.data]['name']}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.person_outline_outlined),
                      Text("${food[widget.data]['people']}"),
                      SizedBox(width: 30),
                      Icon(Icons.timer_outlined),
                      Text("${food[widget.data]['time']}")
                    ],
                  ),
                ),
                Divider(
                  thickness: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, top: 8.0, right: 16.0, bottom: 0.0),
                  child: Text("재료",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, top: 8.0, right: 30.0, bottom: 0.0),
                        child: Column(
                          children: [for (int i = 0; i < mat; i++) materi(i)],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("조리순서",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                for (int i = 0; i < process_length; i++)
                  Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, top: 2.0, right: 25.0, bottom: 8.0),
                      child: process(i, i + 1, process_length)),
                Divider(
                  thickness: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget materi(int num) {
    return Column(
      children: [
        Text("${food[widget.data]['material'][num]}"),
        Divider(
          thickness: 2,
        )
      ],
    );
  }

  Widget process(int num, int pri, int leng) {
    return Column(
      children: [
        Text("STEP $pri/$leng",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 10),
        Text("${food[widget.data]['how'][num]}"),
        SizedBox(height: 10),
      ],
    );
  }
}
