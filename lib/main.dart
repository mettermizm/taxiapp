import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/base_location.dart';
import 'package:taxiapp/class/model/payment_model.dart';
import 'package:taxiapp/class/model/taxi_people_model.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/class/model/user_model.dart';
import 'package:taxiapp/firebase_options.dart';
import 'package:taxiapp/pages/auth/authentication.dart';
import 'package:taxiapp/pages/map_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
        ChangeNotifierProvider(create: (context) => UserModel()),
        ChangeNotifierProvider<BaseLocation>(create: (context) => BaseLocation()),      
      ],
      child: MyApp(),
    ),
  );
}

Future<bool> requestLocationPermission() async {
  final PermissionStatus status = await Permission.locationWhenInUse.request();
  if (status.isDenied) {
    return false;
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
    return false;
  } else if (status.isGranted) {
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Taxi',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          themeNotifier.isDarkMode == true ? ThemeMode.dark : ThemeMode.light,
      home: FutureBuilder<bool>(
        future: requestLocationPermission(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final bool hasPermission = snapshot.data ?? false;
            return hasPermission ? LoginPage() : ErrorWidget();
          }
        },
      ),
    );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Konum izni vermeniz gerekmektedir'),
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Konum izni vermeniz gerekmektedir'),
              ElevatedButton(
                onPressed: () async {
                  bool hasPermission = await requestLocationPermission();
                  if (hasPermission) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } else {
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
