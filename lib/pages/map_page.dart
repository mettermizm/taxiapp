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

// ignore: must_be_immutable
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
  Set<Polyline> _polylines = Set<Polyline>();
  int _polylineIdCounter = 1;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showOtherWidgets = true;
  LatLng startPoint =
      LatLng(38.41465813848041, 27.13873886099405); // Örnek başlangıç noktası
  LatLng endPoint =
      LatLng(38.41170946334618, 27.128457612315454); // Örnek bitiş noktası

  @override
  void initState() {
    super.initState();
    iconBytes = loadIconBytes('assets/car.png');

    // calculateDistance fonksiyonunu burada async olarak çağırıyoruz ve sonucunu bekliyoruz
    calculateDistance(
      LatLng(38.41170946334618, 27.128457612315454),
      LatLng(widget.marker?['lat'] ?? 37.7749,
          widget.marker?['lang'] ?? -122.4194),
    ).then((result) {
      setState(() {
        distance = result; // Sonucu distance değişkenine atıyoruz
      });
      print('İki Marker arasındaki mesafe: $distance metre');
    });

    _addPolyline(startPoint, endPoint);
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

  void _addPolyline(LatLng startPoint, LatLng endPoint) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 5,
        color: Colors.blue,
        points: [startPoint, endPoint],
      ),
    );
  }

  Future<Uint8List> loadIconBytes(String assetPath) async {
    final ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  String _mapStyleForDarkMode = '''
[
  {
    "stylers": [
      {
        "weight": 6
      }
    ]
  },
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#242f3e"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "weight": 8
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#263c3f"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#6b9a76"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#38414e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#212a37"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9ca5b3"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#746855"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1f2835"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#f3d19c"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#2f3948"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#d59563"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#17263c"
      },
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#515c6d"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#17263c"
      }
    ]
  }
]
''';

  String _mapStyleForLightMode = ''' 
  [
  {
    "stylers": [
      {
        "weight": 6
      }
    ]
  },
  {
    "featureType": "landscape.natural",
    "elementType": "geometry",
    "stylers": [
      {
        "weight": 8
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  }
]''';

    GoogleMapController? _mapController;


void _setMapStyle(bool isDarkMode) {
  if (_mapController == null) return;
  
  _mapController!.setMapStyle(
    isDarkMode ? _mapStyleForDarkMode : _mapStyleForLightMode
  );
}


  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

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
                onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _setMapStyle(isDarkMode); // İlk map stilini ayarlayın
                },
                polylines: _polylines,
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
