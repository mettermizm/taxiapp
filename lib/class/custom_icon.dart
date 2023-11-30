import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/theme.dart';

class MyCustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Provider.of<ThemeNotifier>(context).isDarkMode == true
              ? Colors.black
              : Colors.white,
        shape: BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3), // Gölge rengi
            spreadRadius: 2, // Gölgenin yayılma miktarı
            blurRadius: 5, // Gölge bulanıklığı
            offset: Offset(0, 3), // Gölgenin konumu (x, y)
          ),
        ],
      ),
      child: Icon(
        Icons.menu,
        color:Provider.of<ThemeNotifier>(context).isDarkMode == true
              ? Colors.white
              : Colors.black, 
      ),
    );
  }
}