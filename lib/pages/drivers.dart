import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/auth_service.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/chat_page.dart';

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

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0, // Shadow'yu kaldır
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              top: 12,
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  PopupMenuButton<String>(
                    icon: Icon(Icons.filter_list,
                        color:
                            isDarkMode == true ? Colors.white : Colors.black),
                    onSelected: (String result) {
                      setState(() {
                        selectedFilter = result;
                      });
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: '5 km',
                        child: Text('5 km',
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '25 km',
                        child: Text('25 km',
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '50 km',
                        child: Text('50 km',
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '75 km',
                        child: Text('75 km',
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                      PopupMenuItem<String>(
                        value: '100 km',
                        child: Text('100 km',
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : Colors.black)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(selectedFilter,
                            style: TextStyle(
                                color: isDarkMode == true
                                    ? Colors.white
                                    : Colors.black)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length, // Liste öğelerinin sayısı
              itemBuilder: (BuildContext context, int index) {
                var userData = snapshot.data!.docs[index].data();
                String email = userData['email'];
                final person = peopleList[index];

                // Filtreleme kontrolü
                if (selectedFilter != 'Filtrele') {
                  final selectedDistance =
                      int.tryParse(selectedFilter.split(' ')[0]) ?? 0;
                  final personDistance =
                      int.tryParse(person['distance']?.split(' ')[0] ?? '0') ??
                          0;

                  if (personDistance > selectedDistance) {
                    return Container(); // Filtrelenenleri gösterme
                  }
                }

                if (_auth.currentUser!.email != userData['email']) {
                  String displayName = userData['displayName'] ?? 'Ebrar Demir';
                  return SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.15, // Ekran yüksekliğinin %30'u kadar bir değer
                    child: Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      child: ListTile(
                          leading: CircleAvatar(
                            // Profil resmi ekleme
                            backgroundImage:
                                NetworkImage(person['avatarUrl'] ?? ''),
                          ),
                          title: Text(displayName),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(person['distance'] ?? ''),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Text(person["rate"].toString()),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  )
                                ],
                              )
                            ],
                          ),
                          trailing: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatPage(
                                            recieverUserEmail: email,
                                            receiverUserID: userData['uid'],
                                          )));
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateColor.resolveWith((states) {
                                // Butonun durumuna göre renk belirleme
                                if (states.contains(MaterialState.pressed)) {
                                  // Basıldığında renk
                                  return Colors.grey;
                                }
                                // Diğer durumlar için renk
                                return Colors.amber;
                              }),
                            ),
                            child: Text(
                              'Teklif Ver',
                              style: TextStyle(
                                  color: isDarkMode == true
                                      ? Colors.white
                                      : Colors.white),
                            ),
                          )),
                    ),
                  );
                } else {
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        0.15, 
                    child: Container(
                      child: Text(
                        '${_auth.currentUser!.email}  HELLO   ${userData['email']}'),
                    ),
                  );
                }
              },
            );
          }),
    );
  }
}
