import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

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
        fav = Icon(Icons.star_outline_outlined, color: Colors.green, size: 30);
        int num = 1;
      });
    } else {
      setState(() {
        fav = Icon(Icons.star, color: Colors.green, size: 30);
        int num = 0;
      });
    }
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
        actions: [
          IconButton(
            onPressed: () => setState(() {
              if (num == 0) {
                fav = Icon(Icons.star_outline_outlined,
                    color: Colors.green, size: 30);
                num = 1;
                _prefs.remove("${widget.data}");
              } else {
                fav = Icon(Icons.star, color: Colors.green, size: 30);
                num = 0;
                _prefs.setInt("${widget.data}", widget.data);
              }
            }),
            icon: fav,
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200,
                    maxWidth: 200,
                  ),
                  child: Image.asset(
                    "${beer[widget.data]['image']}",
                  ),
                ),
              ),
            ],
          ),
          Divider(
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 16.0, right: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("${beer[widget.data]['name']}",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${beer[widget.data]['type']}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    SizedBox(width: 20),
                    Text("${beer[widget.data]['alcohol']}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            thickness: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 16.0, top: 8.0, right: 16.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                    child: WrappedKoreanText("${beer[widget.data]['dis']}",
                        style: TextStyle(
                            color: Colors.black,
                            height: 2.0,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
