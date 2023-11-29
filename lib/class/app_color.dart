import 'package:flutter/material.dart';

class AppColors {
  static final light_theme = _LightColors();
  static final dark_theme = _DarkColors();
}

class _LightColors {
  Color get backgroundColor => Color.fromARGB(255, 255, 250, 250);
  Color get wigdetColor => Color(0x1C1C1C);//Light theme için başka bulmak gerekiyor 
  Color get fontColor => Color.fromARGB(255, 255, 250, 250);//Kullanımda Değil
  Color get iconColor => Color.fromARGB(255, 255, 250, 250);
}

class _DarkColors {
  Color get backgroundColor => Color(0x1C1C1C);//#1C1C1C
  Color get fontColor => Color.fromARGB(255, 255, 250, 250);//Kullanımda Değil
  Color get iconColor => Color.fromARGB(255, 255, 250, 250);//#FF9800
  Color get wigdetColor => Color.fromARGB(255, 39, 34, 43);
}


/*
#FF9800 = Icon color 1
#1C1C1C = dark theme background color 
#27222B = widget color 
#FFC100 = Icon color 2 
*/