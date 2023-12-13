import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BaseLocation with ChangeNotifier {
   static Map<String, dynamic> _baseLocation = {
    'saat_kulesi': {
      'name': 'İzmir Saat Kulesi',
      'adres': 'Kemeraltı Çarşısı, 35360 Konak/İzmir',
      'lat': 38.41170946334618,
      'lang': 27.128457612315454
    },
    'adnan_menderes_havalimani': {
      'name': 'Adnan Menderes Havalimanı',
      'adres': 'Dokuz Eylül, 35410 Gaziemir/İzmir',
      'lat': 38.2921319298416,
      'lang': 27.148907594283028
    },
    'kültürpark': {
      'name': 'Kültürpark İzmir',
      'adres': 'Mimar Sinan, Şair Eşref Blv. No.50, 35220 Konak/İzmir',
      'lat': 38.42869959642496,
      'lang': 27.14531281039571
    },
    'camii': {
      'name': 'Konak Cami',
      'adres': 'Konak, İzmir Valiliği İç yolu No:4, 35250 Konak/İzmir',
      'lat': 38.415882284869056,
      'lang': 27.181388568065596
    },
    'mini_mutfak_cafe': {
      'name': 'Mini Mutfak Cafe',
      'adres': 'Kılıç Reis, 320. Sk. no:5A, 35280 Konak/İzmir',
      'lat': 38.405854490962575,
      'lang': 27.117985539230176
    },
    'mithatpasa_lisesi': {
      'name': 'Mithatpaşa Mesleki ve Teknik Anadolu Lisesi',
      'adres': 'Küçükyalı Mah, Mithatpaşa Cd. No:469, 35280 Konak/İzmir',
      'lat': 38.40715514257953,
      'lang': 27.10742308105152
    },
  };

  // Getter metodu
  Map<String, dynamic> get baseLocation => _baseLocation;

  // Setter metodu
  set baseLocation(Map<String, dynamic> newBaseLocation) {
    _baseLocation = newBaseLocation;
    notifyListeners();
    saveBaseLocationToPrefs(newBaseLocation);
  }

  Future<void> saveBaseLocationToPrefs(Map<String, dynamic> baseLocation) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(baseLocation);
    await prefs.setString('baseLocation', jsonString);
  }

  Future<void> initializeBaseLocationFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('baseLocation');

    if (jsonString != null && jsonString.isNotEmpty) {
      final Map<String, dynamic> savedBaseLocation = jsonDecode(jsonString);
      _baseLocation = savedBaseLocation;
      notifyListeners();
    }
  }
}