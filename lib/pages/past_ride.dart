
import 'package:flutter/material.dart';

class PastRide extends StatefulWidget {
  const PastRide({super.key});

  @override
  State<PastRide> createState() => _PastRideState();
}

class _PastRideState extends State<PastRide> {
  final List<Map<String, dynamic>> pastRide = [
    {
      "yol": "Ocakci Holding - Çiğli İzban",
      "tarih": "27/11/2023",
      "avatarUrl":
          "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",
      "sure": "15 dk",
      "price": "100 TL",
    },
    {
      "yol": "Bornova Metro - Ocakci Holding",
      "tarih": "24/11/2023",
      "avatarUrl":
          "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "15 dk",
      "price": "450 TL",
    },
    {
      "yol": "Hasanağa Bahçesi - Şirinyer İzban",
      "tarih": "20/10/2023",
      "avatarUrl":
          "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "20 dk",
      "price": "145 TL",
    },
    {
      "yol": "İstinye Park - Halkapınar",
      "tarih": "11/10/2023",
      "avatarUrl":
          "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "60 dk",
      "price": "900 TL",
    },
    {
      "yol": "Dokuz Eylül Hastanesi - Agora Avm",
      "tarih": "02/10/2023",
      "avatarUrl":
          "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "15 dk",
      "price": "200 TL",
    },
    {
      "yol": "Dokuz Eylül Hastanesi - Agora Avm",
      "tarih": "02/10/2023",
      "avatarUrl":
                   "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "15 dk",
      "price": "200 TL",
    },
    {
      "yol": "Dokuz Eylül Hastanesi - Agora Avm",
      "tarih": "02/10/2023",
      "avatarUrl":
                   "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "15 dk",
      "price": "200 TL",
    },
    {
      "yol": "Dokuz Eylül Hastanesi - Agora Avm",
      "tarih": "02/10/2023",
      "avatarUrl":
                   "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "15 dk",
      "price": "200 TL",
    },
    {
      "yol": "Dokuz Eylül Hastanesi - Agora Avm",
      "tarih": "02/10/2023",
      "avatarUrl":
                 "https://w7.pngwing.com/pngs/561/324/png-transparent-location-address-position-linear-icon-location-address-position.png",

      "sure": "15 dk",
      "price": "200 TL",
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
        itemCount: pastRide.length, // Liste öğelerinin sayısı
        itemBuilder: (BuildContext context, int index) {
          // İndex'e göre kişi verisini alın
          final person = pastRide[index];

          return Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height *
                  0.15, // Minimum yükseklik
            ),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(person['avatarUrl'] ?? ''),
                ),
                title: Text(person['yol'] ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person['tarih'] ?? ''),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(person["sure"].toString()),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ],
                    )
                  ],
                ),
                trailing: Text(person["price"].toString()),
              ),
            ),
          );
        },
      ),
    );
  }
}
