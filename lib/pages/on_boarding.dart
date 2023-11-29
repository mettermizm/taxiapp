import 'package:flutter/material.dart';
import 'package:taxiapp/pages/map_page.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  late PageController _controller;

  final List<Map<String, dynamic>> onboardingData = [
    {"title": "İstediğin Her Yerden Taksi Çağır", 
    "description": "Anlık konumuna göre etrafındaki müsait taksileri haritadan veya En Yakın Taksiler bölümünden görebilirsin.", 
    "image": 15
    },
    {"title": "İstediğin Taksi Modelini Seç", 
    "description": "En Yakın Taksiler kısmından yolculuk yapmak istediğin taksi modelini, taksinin dakika bazından ücretini ve sana olan uzaklığını görebilirsin. En uygun fiyatlı veya sana en yakın taksiyi seçip onunla yolculuk yapabiirsin.", 
    "image": 15
    },
    {"title": "En Yüksek Puanlı Şoförlerle Seyehat İmkanı", 
    "description": "Eğer sadece yüksek puanlı şoförlerle seyehat etmek istiyorsan, 100 Km çapındaki yüksek puanlı bir taksiciyi seçip onun uzaklığına bağlı olarak fiyat teklif edebilirsin.", 
    "image": 15
    },
    {"title": "Taksi Çağırmadan Ödeyeceğin Tutarı Gör", 
    "description": "Takisiyi çağırmadan ücret hesaplamak için önce yolculuk yapacağın taksiyi seç, daha sonra gideceğin yeri seç ve ödeyeceğin ücreti gördükten sonra Taksi Çağır butonuna tıkla.", 
    "image": 15
    },
  ];

  @override 
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: onboardingData.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    children: [
                      Image.asset("assets/car.png", height: 300),
                      Text(
                        onboardingData[i]["title"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        onboardingData[i]["description"],
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(onboardingData.length, (index) => buildDot(index, context))
              ],
            ),
          ),
          Container(
            height: 60,
            width: double.infinity,
            margin: EdgeInsets.all(40),
            color: Colors.transparent,
            child: ElevatedButton(
              onPressed: () {
                if (currentIndex == onboardingData.length - 1) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
                }
                _controller.nextPage(duration: Duration(milliseconds: 100), curve: Curves.bounceIn,);
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              ),
              child: Text(
                'Devam',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context ) {
    return Container(
                height: 10,
                width: currentIndex == index ? 25 : 10,
                margin: EdgeInsets.only(right: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                ),
              );
  }
}
