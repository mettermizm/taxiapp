
class DataProvider with ChangeNotifier {
   final List<Map<String, dynamic>> carData = [
    {"name": "Toyota Corolla Hatchback", "status": "yakınlarda", "price": 15},
    {"name": "Renault Clio", "status": "0.5 Km", "price": 11},
    {"name": "Hyundai Elantra", "status": "0.8 Km", "price": 18},
    {"name": "Hyundai Accent Blue", "status": "1.1 Km", "price": 21},
    {"name": "Ford Focus", "status": "1.2 Km", "price": 16},
    {"name": "Ford Mustang", "status": "1.5 Km", "price": 35},
  ];

  String selectedCar = "Lütfen Araç Seçin";
  int selectedPrice = 0;

  void carSec(int index) {
    if (index >= 0 && index < carData.length) {
      selectedCar = carData[index]["name"];
      selectedPrice = carData[index]["price"];
      notifyListeners();
    }
  }
}
class Data {
  static final List<Map<String, String>> carData = [
    {"name": "Toyota Corolla Hatchback", "status": "yakınlarda"},
    {"name": "Renault Clio", "status": "0.5 Km"},
    {"name": "Hyundai Elantra", "status": "0.8 Km"},
    {"name": "Hyundai Accent Blue", "status": "1.1 Km"},
    {"name": "Ford Focus", "status": "1.2 Km"},
    {"name": "Ford Mustang", "status": "1.5 Km"},
  ];
}
