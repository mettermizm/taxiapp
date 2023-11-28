import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData currentTheme;
  bool get isDarkMode => currentTheme.brightness == Brightness.dark;

  ThemeNotifier() : currentTheme = ThemeData.light();

  void initializeTheme() async {
    final prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    currentTheme = isDarkMode ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
  }

  void toggleTheme() async {
    currentTheme = isDarkMode ? ThemeData.light() : ThemeData.dark();
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
} 
