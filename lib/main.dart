import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:taxiapp/class/custom_icon.dart';
import 'package:taxiapp/class/custom_drawer.dart';
import 'class/bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
 
void main() {
  runApp(const MyApp());
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
 
 
Future<bool> requestLocationPermission() async {
  final PermissionStatus status = await Permission.locationWhenInUse.request();
  if (status.isDenied) {
    return false;
  } else if (status.isPermanentlyDenied) {
    // Kullanıcı izni kalıcı olarak reddetti, ayarlara yönlendir
    openAppSettings();
    return false;
  } else if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}
 
void calculateUserDistance() async {
  try {
    Position position = await getCurrentLocation();
    double distance = calculateDistance(lat1: position.latitude, lon1: position.longitude, lat2: 38.41170946334618, lon2: 27.128457612315454);
    print("Kullanıcı ile belirtilen nokta arasındaki mesafe: $distance km");
  } catch (e) {
    print("Hata: $e");
  }
}
 
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Taxi',
      home: FutureBuilder<bool>(
        future: requestLocationPermission(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veri henüz yüklenmediyse, örneğin bir yükleme animasyonu gösterebilirsiniz.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // Hata durumunda ne yapılacağını belirleyin.
            return Text('Hata: ${snapshot.error}');
          } else {
            // İzin verildiyse veya reddedildiyse, duruma göre bir sayfa oluşturun.
            final bool hasPermission = snapshot.data ?? false;
            return hasPermission ? MyHomePage() : ErrorWidget();
          }
        },
      ),
      // home: SearchArea(),
    );
  }
}
 
double calculateDistance({lat1, lon1, lat2, lon2}) {
  const double radius = 6371; // Dünya yarıçapı (km)
  final double lat1Rad = degreesToRadians(38.475370256050795);
  final double lon1Rad = degreesToRadians(27.03760666748706);
  final double lat2Rad = degreesToRadians(38.41170946334618);
  final double lon2Rad = degreesToRadians(27.128457612315454);
 
  final double dLat = lat2Rad - lat1Rad;
  final double dLon = lon2Rad - lon1Rad;
 
  final double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
 
  final double distance = radius * c;
  return distance;
}
 
double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}
 
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
 
class ErrorWidget extends StatefulWidget {
  const ErrorWidget({super.key});
 
  @override
  State<ErrorWidget> createState() => _ErrorWidgetState();
}
 
class _ErrorWidgetState extends State<ErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konum izni vermeniz gerekmektedir'),
      ),
      body: Center(
          child: Container(
            alignment: Alignment.center, // İçeriği ekranın ortasına hizalar
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Sütun içeriğini dikeyde ortalar
              children: [
                Text('Konum izni vermeniz gerekmektedir'),
                ElevatedButton(
                  onPressed: () async {
                    bool hasPermission = await requestLocationPermission();
                    if (hasPermission) {
                      // İzin verildi, ana sayfaya yönlendir
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => MyHomePage()),
                      );
                    } else {
                      // İzin verilmedi, hata mesajını göster
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Konum izni gereklidir!')),
                      );
                    }
                  },
                  child: Text('İzni Yeniden Dene'),
                )
              ],
            ),
          ),
        ),
    );
  }
}
 
void _showDialog(BuildContext context) async {
  double mesafe = await calculateDistance();
  print(mesafe);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Başlık'),
        content: Text('$mesafe'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dialog'u kapat
            },
            child: Text('Tamam'),
          ),
        ],
      );
    },
  );
}