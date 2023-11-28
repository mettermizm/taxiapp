import 'package:flutter/material.dart';
import 'package:taxiapp/class/model/taxi_people_model.dart';

class Peoples extends StatefulWidget {
  const Peoples({super.key});

  @override
  State<Peoples> createState() => _PeoplesState();
}

class _PeoplesState extends State<Peoples> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0, // Shadow'yu kaldır
      ),
      body: ListView.builder(
        itemCount: Data.peopleList.length, // Liste öğelerinin sayısı
        itemBuilder: (BuildContext context, int index) {
          // İndex'e göre kişi verisini alın
          final person = Data.peopleList[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: CircleAvatar(
                // Profil resmi ekleme
                backgroundImage: NetworkImage(person['avatarUrl'] ?? ''),
              ),
              title: Text(person['name'] ?? ''), // Kişi adı
              subtitle: Text(person['status'] ?? ''), // Kişi mesleği veya açıklaması
              // İsteğe bağlı olarak diğer bilgileri de ekleyebilirsiniz
              // Örneğin: yaş, şehir, vb.
              trailing: Text(person['name'] ?? ''),
              // subtitle: Text(person['city'] ?? ''),
              // vb.
            ),
          );
        },
      ),
    );
  }
}
