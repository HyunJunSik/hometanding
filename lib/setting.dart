import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/HyunJunSik/hometanding');
final Uri _url2 = Uri.parse('https://www.instagram.com/lambda3141/?hl=ko');

class setting extends StatelessWidget {
  const setting({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Application Info"),
        backgroundColor: Color(0xFF2DA30D),
        actions: [
          TextButton(
            child:
                Text("야옹", style: TextStyle(color: Colors.black, fontSize: 15)),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => cat()));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Divider(),
            ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 20,
                  minWidth: 20,
                  maxHeight: 150,
                  maxWidth: 150,
                ),
                child: Image.asset('assets/mainicon.png')),
            Divider(),
            Text("프로젝트 : 알콜위키", style: TextStyle(fontSize: 20)),
            Text("version 3.2 (11/27)", style: TextStyle(fontSize: 20)),
            Divider(),
            TextButton(
              child: Text("click me if you want to see code",
                  style: TextStyle(fontSize: 20)),
              onPressed: _launchUrl,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(_url)) throw 'Could not launch $_url';
  }
}

class cat extends StatelessWidget {
  const cat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: [
            Flexible(child: Container()),
            Flexible(
              child: InkWell(
                onTap: () {
                  _launchUrl();
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset("assets/lambda.jpg", fit: BoxFit.fill),
                ),
              ),
            ),
            Flexible(
                child: Text("Dev.Lambda",
                    style: TextStyle(fontStyle: FontStyle.italic))),
          ],
        ),
      ),
    );
  }

  void _launchUrl() async {
    if (!await launchUrl(_url2)) throw 'Could not launch $_url';
  }
}
