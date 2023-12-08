import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';
import 'package:taxiapp/pages/map_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _mockCheckForSession();
  }

  Future<void> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2500), () {
    });
     Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (BuildContext context) => MyHomePage()
      )
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            // Opacity(
            //     opacity: 0.5,
            //     child: Image.asset('assets/project_taxi_son.png')),
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
            )
          ],
        ),
      ),
    );
  }
}
