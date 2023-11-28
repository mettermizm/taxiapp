import 'package:flutter/material.dart';
import 'package:taxiapp/pages/AccountProfile.dart';
import 'package:taxiapp/pages/FavoriteAdres.dart';
import 'package:taxiapp/pages/Options.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final List<Map<String, dynamic>> accounts = [
    {
      "name": "Profil Bilgileri",
      "url": "AccountProfile",
      "icon": Icons.person,
    },
    {
      "name": "Tercihlerim",
      "url": "Options",
      "icon": Icons.verified_user,
    },
    {
      "name": "Favori Adreslerim",
      "url": "FavoriteAdress",
      "icon": Icons.star,
    },
    {
      "name": "Hesap Ayarları",
      "url": "AccountSettings",
      "icon": Icons.settings,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: accounts.length, // Liste öğelerinin sayısı
        itemBuilder: (BuildContext context, int index) {
          // İndex'e göre kişi verisini alın
          final person = accounts[index];

          return Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height *
                  0.15, // Minimum yükseklik
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: ListTile(
                  onTap: (){

                 if (person['name'] == 'Profil Bilgileri') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountProfile()),
      );
    } else if (person['name'] == 'Tercihlerim') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Options()),
      );
    } else if (person['name'] == 'Favori Adreslerim') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FavoriteAdres()),
      );
    } else if (person['name'] == 'Hesap Ayarları') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AccountProfile()),
      );
    }
  },
                  leading: Icon(person['icon'],size: 30.0, color: Colors.orange, ),
                  title: Text(
                    person['name'] ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
