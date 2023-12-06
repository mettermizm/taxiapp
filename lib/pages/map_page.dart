// ignore: must_be_immutable
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/bottom_bar.dart';
import 'package:taxiapp/class/custom_drawer.dart';
import 'package:taxiapp/class/custom_icon.dart';
import 'package:taxiapp/class/model/theme.dart';

class MyHomePage extends StatefulWidget {
  Map<String, dynamic>? baslangic;
  Map<String, dynamic>? marker;

  MyHomePage({super.key, this.baslangic, this.marker});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Uint8List> iconBytes;
  late double distance; // double türünde bir değişken tanımlıyoruz

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showOtherWidgets = true;

  @override
  void initState() {
    super.initState();
    iconBytes = loadIconBytes('assets/car.png');

    // calculateDistance fonksiyonunu burada async olarak çağırıyoruz ve sonucunu bekliyoruz
    calculateDistance(
      LatLng(38.41170946334618, 27.128457612315454),
      LatLng(widget.marker?['lat'] ?? 37.7749, widget.marker?['lang'] ?? -122.4194),
    ).then((result) {
      setState(() {
        distance = result; // Sonucu distance değişkenine atıyoruz
      });
      print('İki Marker arasındaki mesafe: $distance metre');
    });
  }
  // İki nokta arasındaki mesafeyi hesaplar
  Future<double> calculateDistance(LatLng start, LatLng end) async {
    final Position startPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final double distanceInMeters = await Geolocator.distanceBetween(
      startPosition.latitude,
      startPosition.longitude,
      end.latitude,
      end.longitude,
    );

    return distanceInMeters;
  }

  Future<Uint8List> loadIconBytes(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          FutureBuilder<Uint8List>(
            future: iconBytes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // İkon yüklenene kadar bekleme göstergesi
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final Uint8List iconData = snapshot.data!;

              return GoogleMap(
                onCameraMove: (p0) => {
                  setState(() {
                    showOtherWidgets = false;
                  })
                },
                onCameraIdle: () => {
                  setState(() {
                    showOtherWidgets = true;
                  })
                },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(widget.marker?['lat'] ?? 38.41465813848041,
                        widget.marker?['lang'] ?? 27.13873886099405),
                    zoom: 14.0),
                markers: Set<Marker>.of([
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: LatLng(38.41465813848041, 27.13873886099405),
                    infoWindow: InfoWindow(
                      title: 'San Francisco',
                      snippet: 'Example Marker',
                    ),
                  ),
                  Marker(
                    markerId: MarkerId('marker_2'),
                    position: LatLng(widget.marker?['lat'] ?? 37.7749,
                        widget.marker?['lang'] ?? -122.4194),
                    icon: BitmapDescriptor.fromBytes(
                        iconData), // İkon baytlarını kullanın
                    infoWindow: InfoWindow(
                      title: widget.marker?['name'] ?? "Undefined",
                      snippet: "Seçilen Konum",
                    ),
                  )
                ]),
              );
            },
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
                  color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                      ? Colors.black
                      : Colors.black,
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
