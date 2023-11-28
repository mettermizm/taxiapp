import 'package:flutter/material.dart';
import 'package:taxiapp/class/model/taxi_people_model.dart';
 
class Taxis extends StatefulWidget {
  const Taxis({Key? key}) : super(key: key);
 
  @override
  State<Taxis> createState() => _TaxisState();
}
 
class _TaxisState extends State<Taxis> {
  // Araba verilerini içeren liste
 
  String selectedCar = "";
 
  @override
  void initState() {
    super.initState();
    selectedCar = Data.carData.isNotEmpty ? Data.carData[0]["name"]! : "";
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0, // Shadow'yu kaldır
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Data.carData.length,
              itemBuilder: (context, index) {
                return buildCustomContainer(
                  Data.carData[index]["name"]!,
                  Data.carData[index]["status"]!,
                  Data.peopleList[index]['avatarUrl']!,
                );
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 4,
                  blurRadius: 5,
                  offset: const Offset(6, 4),
                )
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Seçilen Taksi", style: TextStyle(fontSize: 20, )),
                        Text(selectedCar, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16 )),
                      ],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Devam Et",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      print("Devam");
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      elevation: 5,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
 
  Widget buildCustomContainer(String carName, String status, String avatarUrl) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
                // Profil resmi ekleme
                backgroundImage: NetworkImage(avatarUrl),
              ),
            //Icon(Icons.local_taxi, color: Colors.amber, size: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(carName, style: TextStyle(fontSize: 16)),
                  Text(status, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            TextButton(
              child: Text(
                "Seç",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                setState(() {
                  selectedCar = carName;
                });
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                elevation: 5,
                backgroundColor: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}