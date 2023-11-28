import 'package:flutter/material.dart';
 
class Peoples extends StatefulWidget {
  const Peoples({super.key});
 
  @override
  State<Peoples> createState() => _PeoplesState();
}
 
class _PeoplesState extends State<Peoples> {
  final List<Map<String, dynamic>> peopleList = [
    {
      "name": "Mehmet Kaya",
      "distance": "8 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 5.0   
    },
    {
      "name": "Burak Toprak",
      "distance": "51 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 5.0
    },
    {
      "name": "Onur Yıldız",
      "distance": "1 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 4.5 
    },
    {
      "name": "Kaan Arslan",
      "distance": "72 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 4.0
    },
    {
      "name": "Emre Çelik",
      "distance": "32 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 3.5
    },
    {
      "name": "Hüseyin Demir",
      "distance": "18 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 3.5 
    },
    {
      "name": "Arif Yılmaz",
      "distance": "81 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 3.0 
    },
    {
      "name": "Emre yavuz",
      "distance": "5 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 3.0 
    },
    {
      "name": "Muhammet Doğan",
      "distance": "45 Km Uzaklıkta",
      "avatarUrl":
          "https://th.bing.com/th/id/OIP.MFEWCmd9EcwVIgw9SZCk7wHaHa?rs=1&pid=ImgDetMain",
      "rate": 2.5 
    },
  ];
  String selectedFilter = 'Filtrele';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0, // Shadow'yu kaldır
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12, right: 16,),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.filter_list, color: Colors.black),
                    onSelected: (String result) {
                      setState(() {
                        selectedFilter = result;
                      });
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: '5 km',
                        child: Text('5 km', style: TextStyle(color: Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '25 km',
                        child: Text('25 km', style: TextStyle(color: Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '50 km',
                        child: Text('50 km', style: TextStyle(color: Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '75 km',
                        child: Text('75 km', style: TextStyle(color: Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '100 km',
                        child: Text('100 km', style: TextStyle(color: Colors.black)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(selectedFilter, style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
          
      body: ListView.builder(
        itemCount: peopleList.length, // Liste öğelerinin sayısı
        itemBuilder: (BuildContext context, int index) {
          // İndex'e göre kişi verisini alın
          final person = peopleList[index];

          // Filtreleme kontrolü
           if (selectedFilter != 'Filtrele') {
             final selectedDistance = int.tryParse(selectedFilter.split(' ')[0]) ?? 0;
              final personDistance = int.tryParse(person['distance']?.split(' ')[0] ?? '0') ?? 0;
       
             if (personDistance > selectedDistance) {
               return Container(); // Filtrelenenleri gösterme
             }
           }

          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.15, // Ekran yüksekliğinin %30'u kadar bir değer
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: ListTile(
                leading: CircleAvatar(
                  // Profil resmi ekleme
                  backgroundImage: NetworkImage(person['avatarUrl'] ?? ''),
                ),
                title: Text(person['name'] ?? ''),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person['distance'] ?? ''),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(person["rate"].toString()),
                        SizedBox(width: 4,),
                        Icon(Icons.star, color: Colors.amber, size: 16,)
                      ],
                    )
                  ],
                ), 
                trailing: ElevatedButton(
                  onPressed: () {
                    // Butona tıklandığında yapılacak işlemler
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      // Butonun durumuna göre renk belirleme
                      if (states.contains(MaterialState.pressed)) {
                        // Basıldığında renk
                        return Colors.grey;
                      }
                      // Diğer durumlar için renk
                      return Colors.amber; 
                    }),
                  ),
                  child: Text('Teklif Ver'),
                )
              ),
            ),
          );
        },
      ),
    );
  }
}