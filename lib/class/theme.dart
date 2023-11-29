import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  late ThemeData currentTheme; // late anahtar kelimesi kullan
  bool get isDarkMode => currentTheme.brightness == Brightness.dark;

  ThemeNotifier() {
    // Tema ayarlarını saklayan SharedPreferences'ı başlatın.
    initializeTheme();
  }

  Future<void> initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    currentTheme = isDarkMode ? ThemeData.light() : ThemeData.dark();
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
