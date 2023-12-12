import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'package:taxiapp/pages/map_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    _mockCheckForSession();
  }

  Future<void> _mockCheckForSession() async {
    const int totalMilliseconds = 2500;
    const int updateIntervalMilliseconds = 50;

    // Toplam süre içinde belirli aralıklarla progressValue'yu güncelleyerek çizgiyi ilerlet
    Timer.periodic(Duration(milliseconds: updateIntervalMilliseconds), (timer) {
      if (progressValue < 1.0) {
        setState(() {
          progressValue += (updateIntervalMilliseconds / totalMilliseconds);
        });
      } else {
        timer.cancel();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (BuildContext context) => MyHomePage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Shimmer.fromColors(
                period: Duration(milliseconds: 1500),
                baseColor: Colors.amber,
                highlightColor: Colors.white,
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  child: Image.asset('assets/project_taxi_son.png'),
                ),
              ),
            ),
            Positioned(
              bottom: 16.0,
              child: LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
