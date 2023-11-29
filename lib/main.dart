import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/theme.dart';
import 'package:taxiapp/pages/auth/authentication.dart';
import 'package:taxiapp/pages/map_page.dart';
import 'package:permission_handler/permission_handler.dart';
 
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
      child: const MaterialApp(
        home: AuthenticationPage(),
      ),
    ),
  );
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
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);//Provider.of<ThemeNotifier>(context).themeNotifier.isDarkMode ?
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Taxi',
      theme: ThemeData.light(), // Light tema
      darkTheme: ThemeData.dark(), // Dark tema
      themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light, // Aktif tema modu
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

/*YEDEK KODLAR

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



void calculateUserDistance() async {
  try {
    Position position = await getCurrentLocation();
    double distance = calculateDistance(lat1: position.latitude, lon1: position.longitude, lat2: 38.41170946334618, lon2: 27.128457612315454);
    print("Kullanıcı ile belirtilen nokta arasındaki mesafe: $distance km");
  } catch (e) {
    print("Hata: $e");
  }
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


*/