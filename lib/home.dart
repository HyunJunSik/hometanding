import 'dart:io';
// image.path는 위의 import 'dart:html' 문제였음
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final picker = ImagePicker();

  File _image;
  bool _loading = false;
  List _output;

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {});
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
        numResults: 4,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _loading = false;
      _output = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/model_unquant.tflite',
      labels: 'assets/labels.txt',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ButtonBar(
                    alignment: MainAxisAlignment.center,
                    buttonMinWidth: 150,
                    layoutBehavior: ButtonBarLayoutBehavior.padded,
                    buttonPadding: EdgeInsets.symmetric(vertical: 10),
                    children: <Widget>[
                      ElevatedButton(onPressed: pickImage, child: Text('Cam')),
                      SizedBox(width: 20),
                      ElevatedButton(
                          onPressed: pickGalleryImage, child: Text('Gallery'))
                    ]),
              ],
            ),
            Center(
                child: _loading
                    ? Container(
                        width: 300,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 50),
                            Image.asset('assets/1.png')
                          ],
                        ),
                      )
                    : Container(
                        child: Column(children: <Widget>[
                        _output != null
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  '${_output[0]['label'][0]}',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 20.0),
                                ))
                            : Container(),
                        SizedBox(height: 20),
                        Container(
                          height: 250,
                          child: Image.file(_image),
                        ),
                      ]))),
          ],
        )),
      ),
    );
  }
}
