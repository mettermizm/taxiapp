// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBIZKsBO94efD2-11taN7EIHuwP6ZUoDDI',
    appId: '1:508055291311:web:d520241ac04b54bb069b5a',
    messagingSenderId: '508055291311',
    projectId: 'taxiappprojectnew',
    authDomain: 'taxiappprojectnew.firebaseapp.com',
    storageBucket: 'taxiappprojectnew.appspot.com',
    measurementId: 'G-2Y1Z30XP3N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBHY7ukMeaTQ33AEFB6UxO4avKtxletzC0',
    appId: '1:508055291311:android:b04b14944bd5d716069b5a',
    messagingSenderId: '508055291311',
    projectId: 'taxiappprojectnew',
    storageBucket: 'taxiappprojectnew.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMhnk9BDSzNF4hKh12OnLRG4gJxxQ_lh4',
    appId: '1:508055291311:ios:59861d6e3aecf281069b5a',
    messagingSenderId: '508055291311',
    projectId: 'taxiappprojectnew',
    storageBucket: 'taxiappprojectnew.appspot.com',
    iosBundleId: 'com.example.taxiapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCMhnk9BDSzNF4hKh12OnLRG4gJxxQ_lh4',
    appId: '1:508055291311:ios:28b971aba82eca2d069b5a',
    messagingSenderId: '508055291311',
    projectId: 'taxiappprojectnew',
    storageBucket: 'taxiappprojectnew.appspot.com',
    iosBundleId: 'com.example.taxiapp.RunnerTests',
  );
}
