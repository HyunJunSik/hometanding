import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/HyunJunSik/hometanding');

class setting extends StatelessWidget {
  const setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Application Info")),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Text("소프트웨어 공학 8조", style: TextStyle(fontSize: 30)),
            SizedBox(height: 20),
            ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 20,
                  minWidth: 20,
                  maxHeight: 150,
                  maxWidth: 150,
                ),
                child: Image.asset('assets/mainicon.png')),
            Text("프로젝트 : 알콜위키", style: TextStyle(fontSize: 20)),
            TextButton(
              child: Text("click me if you want to see code",
                  style: TextStyle(fontSize: 20)),
              onPressed: _launchUrl,
            ),
          ],
        ),
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}
