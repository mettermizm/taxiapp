import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/taxi_people_model.dart';
import 'package:taxiapp/pages/search_area.dart';

class Taxis extends StatefulWidget {
  const Taxis({Key? key}) : super(key: key);

  @override
  State<Taxis> createState() => _TaxisState();
}

class _TaxisState extends State<Taxis> {
  // Araba verilerini içeren liste
  // final List<Map<String, dynamic>> carData = [
  //   {"name": "Toyota Corolla Hatchback", "status": "yakınlarda", "price": 15},
  //   {"name": "Renault Clio", "status": "0.5 Km", "price": 11},
  //   {"name": "Hyundai Elantra", "status": "0.8 Km", "price": 18},
  //   {"name": "Hyundai Accent Blue", "status": "1.1 Km", "price": 21},
  //   {"name": "Ford Focus", "status": "1.2 Km", "price": 16},
  //   {"name": "Ford Mustang", "status": "1.5 Km", "price": 35},
  // ];

  String selectedCar = "";
  int selectedPrice = 0;

  int findCarIndex(String selectedCarName) {
    int index = -1;

    var dataProvider = Provider.of<DataProvider>(context,
        listen: false); // DataProvider sınıfından bir nesne oluştur

    for (int i = 0; i < dataProvider.carData.length; i++) {
      if (dataProvider.carData[i]["name"] == selectedCarName) {
        index = i;
        break;
      }
    }

    return index;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   selectedCar = carData.isNotEmpty ? carData[0]["name"]! : "";
  //   selectedPrice = carData.isNotEmpty ? carData[0]["price"]! : 0;
  // }

  @override
  Widget build(BuildContext context) {
    var dataProvider = Provider.of<DataProvider>(context);
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
              // itemCount: carData.length,
              itemCount: dataProvider.carData.length,
              itemBuilder: (context, index) {
                return buildCustomContainer(
                  dataProvider.carData[index]["name"],
                  dataProvider.carData[index]["status"],
                  dataProvider.carData[index]["price"],
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
                        Text("Seçilen Taksi",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        Text('${selectedCar} ${selectedPrice} TL/Km',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Devam Et",
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      String selectedCarName =
                          selectedCar; // Seçilen aracın adını al
                      int carIndex =
                          findCarIndex(selectedCarName); // Aracın indeksini bul

                      if (carIndex != -1) {
                        // Eğer araç bulunduysa
                        Provider.of<DataProvider>(context, listen: false).carSec(
                            carIndex); // Bulunan indeksi kullanarak carSec fonksiyonunu çağır
                      } else {
                        // Araç bulunamadı, hata durumu veya uygun işlem yapılabilir
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchArea()),
                      );
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

  Widget buildCustomContainer(String carName, String status, int price) {
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
            Icon(Icons.local_taxi, color: Colors.amber, size: 28),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Text(carName, style: TextStyle(fontSize: 16)),
                  SizedBox(
                    height: 4,
                  ),
                  Text(status, style: TextStyle(color: Colors.grey)),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${price} TL/Km',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                  selectedPrice = price;
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
