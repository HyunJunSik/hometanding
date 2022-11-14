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
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: it.length,
            itemBuilder: (context, index) {
              return ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                      maxHeight: 40,
                      maxWidth: 40,
                    ),
                    child: Image.asset("${beer[index]['image']}"),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(it[index]),
                  ),
                  subtitle: Text("${beer[index]['type']}"),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => detail(index)));
                  });
            },
          ),
        ),
      ),
    );
  }
}
