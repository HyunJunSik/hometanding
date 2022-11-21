import 'package:flutter/material.dart';
import 'detail.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
// image.path는 위의 import 'dart:html' 문제였음
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

import 'minigame.dart';

class MainPage extends StatefulWidget {
  final int num;
  const MainPage(this.num);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final picker = ImagePicker();

  File _image;
  bool _loading = false;
  List _output;
  var today_beer_name;
  var today_beer_hash;
  var today_beer_alcohol;
  var today_beer_image;
  var today_beer_type;

  @override
  void initState() {
    _loading = true;
    loadModel().then((value) {});
    var todayBeer = widget.num; //추후, splash screen에서 random 설정
    today_beer_name = beer[todayBeer]['name'];
    today_beer_hash = beer[todayBeer]['hash'];
    today_beer_alcohol = beer[todayBeer]['alcohol'];
    today_beer_image = beer[todayBeer]['image'];
    today_beer_type = beer[todayBeer]['type'];
    SnackBar warn = SnackBar(content: Text("잘못된 사진을 사용하였습니다. 다시 시도해주세요"));

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
      if (output.isEmpty) {
        _loading = true;
        print("yes");
      } else {
        _output = output;
      }
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/beer_model.tflite',
      labels: 'assets/labels.txt',
    );
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "기본 토스트 메시지입니다!",
        toastLength: Toast.LENGTH_LONG,
        fontSize: 14,
        backgroundColor: Colors.green);
  }

  void search_dialog(context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Column(
            children: const <Widget>[
              Text(
                "어떻게 검색하실건가요?",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          //
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                splashColor: Colors.red,
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.photo_camera,
                        size: 40, color: Colors.white)),
                onTap: () {
                  pickImage();
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: 50),
              InkWell(
                splashColor: Colors.red,
                child: SizedBox(
                    width: 56,
                    height: 56,
                    child: Icon(Icons.photo_library,
                        size: 40, color: Colors.white)),
                onTap: () {
                  pickGalleryImage();
                  Navigator.pop(context);
                },
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
          backgroundColor: Colors.green,
          // RoundedRectangleBorder - Dialog 화면 모서리 둥글게 조절
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          //Dialog Main Title
          title: Column(
            children: const <Widget>[
              Text("어떤 방법을 택하시겠어요?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
          //
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                  child: Text("재촬영",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickImage();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("갤러리",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    pickGalleryImage();
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("메인화면",
                      style: TextStyle(
                          color: Colors.white,
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
      appBar: AppBar(
        backgroundColor: Color(0xFF2DA30D),
        title: Text("ㅇㅋㅇㅋ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
        centerTitle: true,
      ),
      body: Container(
          child: _loading
              ? Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                strutStyle: StrutStyle(fontSize: 20),
                                text: TextSpan(
                                    text: "Today's beer",
                                    style: GoogleFonts.pacifico(
                                        color: Colors.green, fontSize: 30)),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 210,
                            maxWidth: 210,
                          ),
                          child: Image.asset("${today_beer_image}"),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${today_beer_name}",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${today_beer_hash}",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 14.0,
                                fontStyle: FontStyle.italic))
                      ],
                    ),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      child: IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InkWell(
                              child: Image.asset("assets/Search.png",
                                  width: 160, height: 160),
                              onTap: () {
                                search_dialog(context);
                              },
                            ),
                            VerticalDivider(
                              thickness: 5,
                            ),
                            InkWell(
                              child: Image.asset("assets/alcohol_game.png",
                                  width: 160, height: 160),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => game()));
                              },
                            ),
                          ],
                        ),
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
                    ConstrainedBox(
                      constraints:
                          BoxConstraints(maxWidth: 250, maxHeight: 250),
                      child: Image.asset(
                          "${beer[int.parse(_output[0]['label'])]['image']}",
                          width: double.infinity,
                          height: 300),
                    ),
                    Text(
                      "${beer[int.parse(_output[0]['label'])]['name']}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(8.0),
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
                              child: Text("아닌거같아요..",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 5,
                    ),
                  ],
                )),
    );
  }
}
