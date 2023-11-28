import 'package:flutter/material.dart';
import 'package:taxiapp/pages/account.dart';
import 'package:taxiapp/pages/creditcard.dart';
import 'package:taxiapp/pages/past_ride.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
          child: Container(
            child: Column(
              children: [
                Container(
                color: Colors.amber,
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(shape: BoxShape.circle,),
                    ),
                    Text("Project Taxi", style: TextStyle(color: Colors.white, fontSize: 20,),),
                    Text("info@projecttaxi.com", style: TextStyle(color:  Colors.white, fontSize: 14),)
                  ],
                ),
              ),

              ListTile(
                leading: Icon(Icons.person),
                title: Text('Hesabım'),
                onTap: () {
                  // Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
                },
              ),
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Geçmiş Yolculuklarım'),
                onTap: () {
                  // Navigator.pop(context); // Drawer'ı kapatmak için
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PastRide()));
                },
              ),
              ListTile(
                leading: Icon(Icons.payment),
                title: Text('Ödeme Yöntemlerim'),
                onTap: () {
                  // Navigator.pop(context); // Drawer'ı kapatmak için
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCart()));
                },
              ),
              ListTile(
                leading: Icon(Icons.calculate),
                title: Text('Ücret Hesaplama'),
                onTap: () {
                  Navigator.pop(context); // Drawer'ı kapatmak için
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Yardım'),
                onTap: () {
                  Navigator.pop(context); // Drawer'ı kapatmak için
                },
              ),

              
              ],
            ),
          ),
    );
  }
}
