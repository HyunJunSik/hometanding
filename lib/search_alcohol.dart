import 'package:flutter/material.dart';
import 'detail.dart';
import 'data.dart';

class Alcohol extends StatefulWidget {
  const Alcohol({Key key}) : super(key: key);

  @override
  State<Alcohol> createState() => _AlcoholState();
}

class _AlcoholState extends State<Alcohol> {
  TextEditingController editingController = TextEditingController();
  // final duplicateitems = List<String>.generate(10, (i) => "Beer $i");
  List<String> duplicateitems =
      List<String>.generate(beer.length, (i) => "${beer[i]['name']}");
  var items = <String>[];

  @override
  void initState() {
    items.addAll(duplicateitems);
    super.initState();
  }

  void filterSearchResult(String query) {
    List<String> dummySearchList = <String>[];
    query = query.toLowerCase();
    dummySearchList.addAll(duplicateitems);
    if (query.isNotEmpty) {
      List<String> dummyListData = <String>[];
      for (var item in dummySearchList) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      items.clear();
      items.addAll(duplicateitems);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResult(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                labelText: "맥주 검색",
                hintText: "맥주 검색",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
            ),
          ),
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(items.length, (index) {
              return InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Column(
                        children: [
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                maxHeight: 150,
                                maxWidth: 150,
                              ),
                              child: Image.asset("${beer[index]['image']}")),
                          Text("${beer[index]['name']}")
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => detail(index)));
                  });
            }),
          )),
        ],
      ),
    );
  }
}
