import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/bottom_bar.dart';
import 'package:taxiapp/class/custom_drawer.dart';
import 'package:taxiapp/class/custom_icon.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/services/location_service.dart';

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
  late double distance;
  final Set<Marker> _markers = Set<Marker>();
  final Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polygonLatLngs = <LatLng>[];

  int _polylineIdCounter = 1;
  LatLng? userLocation;
  LatLng? markerLocation;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool showOtherWidgets = true;

  @override
  void initState() {
    super.initState();
    iconBytes = loadIconBytes('assets/car.png');
    _setMarker(LatLng(38.47570, 27.03719));

    getLocationData();
    drawLine();
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.add(
        Marker(markerId: MarkerId('marker'), position: point),
      );
    });
  }

  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servisi etkin mi kontrol et
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Servis kapalı ise kullanıcıya açmasını iste
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        // Kullanıcı servisi açmayı reddetti
        throw Exception('Konum servisleri etkin değil.');
      }
    }

    // Konum izni kontrol et
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // İzin yoksa kullanıcıya izin iste
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Kullanıcı izni reddetti
        throw Exception('Konum izni reddedildi.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Kullanıcı izni sonsuza kadar reddetti
      throw Exception('Konum izni kalıcı olarak reddedildi.');
    }

    // Konum bilgisini al
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getLocationData() async {
  try {
    Position position = await getCurrentLocation(); 

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      markerLocation = LatLng(position.latitude, position.longitude);
    });

    print("Latitude: ${position.latitude}, Longitude: ${position.longitude}");

    // Bu değerleri başka bir işlemde kullanabilirsiniz.
  } catch (e) {
    print("Hata: $e");
  }
}


  // void _setPolygon() {
  //   final String polygonIdVal = 'polygon_$_polygonIdCounter';
  //   _polygonIdCounter++;

  //   _polygons.add(
  //     Polygon(
  //       polygonId: PolygonId(polygonIdVal),
  //       points: polygonLatLngs,
  //       strokeWidth: 2,
  //       fillColor: Colors.transparent,
  //     ),
  //   );
  // }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polygon_$_polylineIdCounter';
    _polylineIdCounter++;
    _polylines.add(
      Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 2,
        color: Colors.blue,
        points: points
            .map(
              (point) => LatLng(point.latitude, point.longitude),
            )
            .toList(),
      ),
    );
  }

  void drawLine() async {
    var directions = await LocationService().getDirections(
        widget.marker?['adres'] ?? 'Küçükyalı Mah, Mithatpaşa Cd. No:469, 35280 Konak/İzmir',
        38.41170946334618,
        27.128457612315454);
    if (directions != null) {
      _goToPlace(
        directions['start_location']['lat'],
        directions['start_location']['lng'],
        directions['bounds_ne'],
        directions['bounds_sw'],
      );
    } else {
      print('Yön bulma başarısız oldu');
    }

    _setPolyline(directions['polyline_decoded']);
    print("tutar");
    if (directions['cost'] != null) {
      print(directions['cost'].toStringAsFixed(2));
      ucret = directions['cost'].toStringAsFixed(2);
    } else {
      print('Coast değeri null');
    }
  }

  String ucret = "0";

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

  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  LatLng? _tappedLocation;


  void _setMapStyle(bool isDarkMode) async {
    final GoogleMapController controller = await _mapController.future;

    if (controller == null) return;

    controller.setMapStyle(
      isDarkMode ? _mapStyleForDarkMode : _mapStyleForLightMode,
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
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final Uint8List iconData = snapshot.data!;

              return GoogleMap(
                onMapCreated: (GoogleMapController controller) {
                  _setMapStyle(isDarkMode);
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
                onTap: (LatLng location) {
                    // Haritada tıklanan yerin konumunu al
                    setState(() {
                      _tappedLocation = location;
                    });

                    // Tıklanan yere işaret koy
                    _placeMarker(location);
                  },
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(38.42159726811209, 27.132838135850328),
                  zoom: 14.0,
                ),
                markers: Set<Marker>.of([
                  Marker(
                    markerId: MarkerId('marker_1'),
                    position: userLocation ?? LatLng(37.7749, -122.4194),
                    infoWindow: InfoWindow(
                      title: 'Konumunuz',
                      snippet: 'Şuan bu konumdasınız',
                    ),
                  ),
                  Marker(
                    markerId: MarkerId('marker_2'),
                    position: markerLocation ?? LatLng(37.7749, -122.4194),
                    icon: BitmapDescriptor.fromBytes(iconData),
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
                elevation: 0,
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
                konum: widget.baslangic == null
                    ? 'Nereye Gitmek İstersiniz?'
                    : widget.marker?['name'],
              ),
            ),
          ),
        ],
      ),
      drawer: CustomDrawer(),
    );
    
  }

  Future<void> _goToPlace(
    // Map<String, dynamic> place
    double lat,
    double lng,
    Map<String, dynamic> boundsNe,
    Map<String, dynamic> boundsSw,
  ) async {
    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12,
        ),
      ),
    );

    controller.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(
              southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
              northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
          25),
    );
    _setMarker(
      LatLng(lat, lng),
    );
  }

  void _placeMarker(LatLng location) {
  // Yeni bir işaretçi (marker) eklemek için
  setState(() {
    _markers.add(
      Marker(
        markerId: MarkerId("tappedLocation"),
        position: location,
        infoWindow: InfoWindow(
          title: "Tıklanan Konum",
          snippet: "Lat: ${location.latitude}, Lng: ${location.longitude}",
        ),
      ),
    );
  });
}


}