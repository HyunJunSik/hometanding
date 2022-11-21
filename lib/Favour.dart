import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data.dart';
import 'detail.dart';

class favourite extends StatefulWidget {
  const favourite({Key key}) : super(key: key);

  @override
  State<favourite> createState() => _favouriteState();
}

class _favouriteState extends State<favourite> {
  List<String> items;
  List<Map> beer_items = [];
  List<String> duplicateitems = [];
  var it = <String>[];
  @override
  void initState() {
    _load();
    super.initState();
  }

  _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> data = prefs.getKeys();
    setState(() {
      items = data.toList();
      for (var i in items) {
        beer_items.add(beer[int.parse(i)]);
      }
      duplicateitems = List<String>.generate(
          beer_items.length, (i) => "${beer_items[i]['name']}");
    });
    it.addAll(duplicateitems);
    print(beer_items);
    print(duplicateitems);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF2DA30D),
          title: Text(
            "즐겨찾기",
          ),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(it.length, (index) {
            return InkWell(
                child: Card(
                  elevation: 10,
                  child: Column(
                    children: <Widget>[
                      ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 150, maxWidth: 150),
                          child: Image.asset("${beer_items[index]['image']}")),
                      Text("${beer_items[index]['name']}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => detail(search(index))));
                });
          }),
        ));
  }

  int search(int index) {
    var name = beer_items[index]['name'];
    for (int i = 0; i < beer.length; i++) {
      if (name == beer[i]['name']) {
        return i;
      }
    }
  }
}
