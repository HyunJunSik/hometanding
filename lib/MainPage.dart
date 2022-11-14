import 'package:flutter/material.dart';
import 'package:hometanding/main.dart';
import 'package:hometanding/setting.dart';
import 'dart:math';
import 'detail.dart';
import 'home.dart';
import 'data.dart';
import 'dart:io';
// image.path는 위의 import 'dart:html' 문제였음
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class MainPage extends StatefulWidget {
  const MainPage();

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final picker = ImagePicker();

  File _image;
  bool _loading = false;
  List _output;

  var today_beer_name;
  var today_beer_dis;
  var today_beer_alcohol;
  var today_beer_image;
  var today_wise;
  var today_name;
  var today_beer_type;

  @override
  void initState() {
    _loading = true;
    loadModel().then((value) {});
    var todayBeer =
        Random().nextInt(beer.length); //추후, splash screen에서 random 설정
    today_beer_name = beer[todayBeer]['name'];
    today_beer_dis = beer[todayBeer]['dis'];
    today_beer_alcohol = beer[todayBeer]['alcohol'];
    today_beer_image = beer[todayBeer]['image'];
    today_beer_type = beer[todayBeer]['type'];

    var todayWise = Random().nextInt(Wise.length);
    today_wise = Wise[todayWise]['wise'];
    today_name = Wise[todayWise]['name'];

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  pickImage() async {
    PickedFile image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      var name = image.path;
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 10,
        threshold: 0.5,
        imageMean: 0.0,
        imageStd: 255.0);
    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/beer_model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  void search_dialog(context) {
    showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: const <Widget>[
              Text("검색 방법"),
            ],
          ),
          //
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ClipOval(
                child: Material(
                  color: Colors.blue,
                  child: InkWell(
                    splashColor: Colors.red,
                    child: SizedBox(
                        width: 56, height: 56, child: Icon(Icons.photo_camera)),
                    onTap: () {
                      pickImage();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              SizedBox(width: 50),
              ClipOval(
                child: Material(
                  color: Colors.blue,
                  child: InkWell(
                    splashColor: Colors.red,
                    child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.photo_library)),
                    onTap: () {
                      pickGalleryImage();
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void search_dialog2(context) {
    showDialog(
      context: context,
      //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: const <Widget>[
              Text("어떤 방법을 택하시겠어요?"),
            ],
          ),
          //
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  child: Text("재촬영",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("갤러리 탐색",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickGalleryImage();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("메인화면",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    setState(() {
                      _loading = true;
                    });
                    Navigator.pop(context);
                  }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.lightBlueAccent,
          child: _loading
              ? Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.grey,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 130),
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                strutStyle: StrutStyle(fontSize: 20),
                                text: TextSpan(
                                  text: "추천드리는 맥주",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25.0,
                                  ),
                                ),
                              ),
                              SizedBox(width: 60),
                              IconButton(
                                  icon: Icon(Icons.question_mark),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => setting()));
                                  }),
                            ],
                          ),
                          RichText(
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            strutStyle: StrutStyle(fontSize: 20),
                            text: TextSpan(
                              text: "${today_beer_name}",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              SizedBox(width: 20),
                              Text("${today_beer_alcohol}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                              SizedBox(width: 20),
                              Text("맥주 구분 : ${today_beer_type}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Container(
                          color: Colors.cyan,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 5,
                                  strutStyle: StrutStyle(fontSize: 16.0),
                                  text: TextSpan(
                                      text: "${today_beer_dis}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        height: 1.4,
                                        fontSize: 16.0,
                                      )),
                                ),
                              ),
                              Image.asset("${today_beer_image}"),
                            ],
                          )),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Column(
                        children: [
                          Text("Wise-Saying",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                            strutStyle: StrutStyle(fontSize: 16.0),
                            text: TextSpan(
                                text: "${today_wise}",
                                style: TextStyle(
                                  color: Colors.black,
                                  height: 1.4,
                                  fontSize: 16.0,
                                )),
                          ),
                          SizedBox(height: 10),
                          Text("${today_name}"),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InkWell(
                            child: Image.asset("assets/Search.png",
                                width: 180, height: 180),
                            onTap: () {
                              search_dialog(context);
                            },
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            child: Image.asset("assets/Favourite.png",
                                width: 180, height: 180),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Home()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  //맥주 확인창 하나 만들어야함.
                  children: [
                    SizedBox(height: 40),
                    Text("이 맥주가 맞나요?",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    SizedBox(height: 40),
                    Image.asset(
                        "${beer[int.parse(_output[0]['label'])]['image']}",
                        width: double.infinity,
                        height: 300),
                    SizedBox(height: 20),
                    Text(
                      "${beer[int.parse(_output[0]['label'])]['name']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(8.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 10),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => detail(
                                        int.parse(_output[0]['label']))));
                                setState(() {
                                  _loading = true;
                                });
                              },
                              child: Text(
                                "오 맞아요!",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                          SizedBox(width: 10),
                          TextButton(
                              onPressed: () {
                                search_dialog2(context);
                              },
                              child: Text("쓰읍..아닌거같은데",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}
