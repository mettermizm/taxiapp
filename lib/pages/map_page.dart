// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxiapp/class/bottom_bar.dart';
import 'package:taxiapp/class/custom_drawer.dart';
import 'package:taxiapp/class/custom_icon.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  Map<String, dynamic>? baslangic;
  Map<String, dynamic>? marker;
  MyHomePage({super.key, this.baslangic, this.marker});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showOtherWidgets = true;
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                  widget.baslangic?['lat'] ?? 38.475370256050795,
                  widget.baslangic?['lang'] ?? 27.03760666748706),
              initialZoom: 14,
              onPositionChanged: (tapPosition, point) => {
                setState(() {
                  showOtherWidgets = false;
                })
              },
              onMapEvent: (p0) => {
                setState(() {
                  showOtherWidgets = true;
                })
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(38.475370256050795, 27.03760666748706),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.location_pin,
                    ),
                  ),
                  Marker(
                    point: LatLng(widget.marker?['lat'] ?? 38.475370256050795,
                        widget.marker?['lang'] ?? 27.03760666748706),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.location_pin,
                    ),
                  ),
                  Marker(
                    point: LatLng(38.47943573660891, 27.053900460537022),
                    width: 90,
                    height: 90,
                    child: Icon(
                      FontAwesomeIcons.taxi,
                    ),
                  ),
                  Marker(
                    point: LatLng(38.493657241651526, 27.045530682513103),
                    width: 90,
                    height: 190,
                    child: Icon(
                      FontAwesomeIcons.taxi,
                    ),
                  ),
                ],
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            top: showOtherWidgets ? 10 : -50,
            left: 10,
            right: 0,
            child: Visibility(
              visible: showOtherWidgets,
              child: AppBar(
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: MyCustomIcon(),
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                  size: 20.0,
                  opacity: 1,
                ),
                elevation: 0, // Remove the shadow
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            bottom: showOtherWidgets ? 0 : -50,
            left: 0,
            right: 0,
            child: Visibility(
              visible: showOtherWidgets,
              child: BottomBar(
                  konum:
                      widget.baslangic == null ? null : widget.marker?['name']),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
  }
}