import 'package:flutter/material.dart';
import 'package:hometanding/main.dart';
import 'dart:math';
import 'home.dart';

List<Map> beer = [
  {
    'name': 'beer1',
    'dis': "이 맥주는 영국에서부터 나와서 이러쿵저러쿵 샬라샬라 하게되었습니다. 아라라라라라라라라",
    'alcohol': 'alcohol1',
    'image': 'assets/maek.jpg'
  },
  {
    'name': 'beer2',
    'dis': '이 맥주는 영국에서부터 나와서 이러쿵저러쿵 샬라샬라 하게되었습니다. 아라라라라라라라라',
    'alcohol': 'alcohol2',
    'image': 'assets/maek.jpg'
  },
  {
    'name': 'beer3',
    'dis': '이 맥주는 영국에서부터 나와서 이러쿵저러쿵 샬라샬라 하게되었습니다. 아라라라라라라라라',
    'alcohol': 'alcohol3',
    'image': 'assets/maek.jpg'
  },
  {
    'name': 'beer4',
    'dis': '이 맥주는 영국에서부터 나와서 이러쿵저러쿵 샬라샬라 하게되었습니다. 아라라라라라라라라',
    'alcohol': 'alcohol4',
    'image': 'assets/maek.jpg'
  },
  {
    'name': 'beer5',
    'dis': '이 맥주는 영국에서부터 나와서 이러쿵저러쿵 샬라샬라 하게되었습니다. 아라라라라라라라라',
    'alcohol': 'alcohol5',
    'image': 'assets/maek.jpg'
  }
];

List<Map> Wise = [
  {
    'wise':
        '맥주를 마시는 자는 잠자리에 빨리 든다. 잠을 많이 자는 자는 죄를 짓지 않는다. 죄를 짓지 않는 자는 천국에 입성한다. 그러니, 우리 모두 맥주를 마시다!',
    'name': '마르틴 루터'
  },
  {'wise': '술은 우리가 삶의 움직임을 이겨내는 마취제이다.', 'name': '조지 버나드 쇼'},
  {'wise': '맥주는 신께서 우리를 사랑하시고 우리가 행복하길 원하신다는 증거다. ', 'name': '벤자민 프랭클린'},
  {'wise': '나는 다른 사람들에게 흥미를 갖기 위해 술을 마신다.', 'name': '어니스트 헤밍웨이'},
  {'wise': '술은 인간 최대의 적일지도 모르나, 성경에서 적을 사랑하라 하셨습니다.', 'name': '프랭크 시나트라'},
  {'wise': '지혜로운 사람은 종종 멍청이들과 어울리기 위해 술을 마셔야 한다.', 'name': '어니스트 헤밍웨이'},
  {
    'wise':
        '나는 치통 예방 차원에서 매일 밤 스카치 위스키를 마십니다. 나는 치통을 한 번도 앓은 적이 없고, 앓을 생각도 없습니다.',
    'name': '마크 트웨인'
  },
  {
    'wise':
        '나는 사람들을 굳게 믿는다. 진실이 주어진다면, 그들은 어떤 국가적 위기에도 대처할 수 있을 것이다. 중요한 점은 그들에게 진짜 진실과맥주를 가져다주는 것이다.',
    'name': '에이브러햄 링컨'
  },
];

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var today_beer_name;
  var today_beer_dis;
  var today_beer_alcohol;
  var today_beer_image;
  var today_wise;
  var today_name;

  @override
  void initState() {
    var todayBeer = Random().nextInt(beer.length);
    today_beer_name = beer[todayBeer]['name'];
    today_beer_dis = beer[todayBeer]['dis'];
    today_beer_alcohol = beer[todayBeer]['alcohol'];
    today_beer_image = beer[todayBeer]['image'];

    var todayWise = Random().nextInt(Wise.length);
    today_wise = Wise[todayWise]['wise'];
    today_name = Wise[todayWise]['name'];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.grey,
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "오늘의 맥주",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text("${today_beer_name}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text("${today_beer_alcohol}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                        SizedBox(width: 20),
                        Text("용량",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.normal)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Flexible(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      strutStyle: StrutStyle(fontSize: 16.0),
                      text: TextSpan(
                          text:
                              '세계문자 가운데 한글,즉 훈민정음은 흔히들 신비로운 문자라 부르곤 합니다. 그것은 세계 문자 가운데 유일하게 한글만이 그것을 만든 사람과 반포일을 알며, 글자를 만든 원리까지 알기 때문입니다.',
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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    Text("Wise Saying"),
                    Text('${Wise[0]['wise']}'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 50),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.search),
                            Text('Search'),
                            Text('Search_discription'),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: const [
                            Icon(Icons.favorite),
                            Text('Favourite'),
                            Text('Favourite_discription'),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
