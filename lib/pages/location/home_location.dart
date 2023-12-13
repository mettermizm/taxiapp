import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/base_location.dart';
import 'package:taxiapp/class/widget_class.dart';
import 'package:taxiapp/services/location_service.dart';

class EvAdresiKaydetSayfasi extends StatefulWidget {
  const EvAdresiKaydetSayfasi({super.key});

  @override
  State<EvAdresiKaydetSayfasi> createState() => _EvAdresiKaydetSayfasiState();
}

class _EvAdresiKaydetSayfasiState extends State<EvAdresiKaydetSayfasi> {
  TextEditingController locationName = TextEditingController();
  TextEditingController ulke = TextEditingController();
  TextEditingController il = TextEditingController();
  TextEditingController ilce = TextEditingController();
  TextEditingController mahalle = TextEditingController();
  TextEditingController sokak = TextEditingController();
  TextEditingController no = TextEditingController();
  LocationService locationService = LocationService();

  String countryName = "Turkey";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ev Adresini Kaydet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                showCountry(context);
              },
              child: Text('Ülke Seç : $countryName'),
            ),
            SizedBox(height: 16.0),
            MyTextFormField(
              controller: il,
              text: 'Şehir',
              type: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            MyTextFormField(
              controller: ilce,
              text: 'İlçe',
              type: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            MyTextFormField(
              controller: mahalle,
              text: 'Mahalle',
              type: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            MyTextFormField(
              controller: sokak,
              text: 'Sokak',
              type: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            MyTextFormField(
              controller: no,
              text: 'No : ',
              type: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Kaydetme işlemi burada gerçekleştirilebilir
                // Örneğin, formu kaydetmek için bir işlev çağrısı ekleyebilirsiniz.
                // Navigator.pop(context); // Sayfayı kapatmak için
                bool deger = popUp(context);
                if (deger == true) {
                  popUp(context);
                  Navigator.pop(context);
                }
              },
              child: Text('Kaydet'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber, // Ana renk
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool saveLocation(BuildContext context) {
    var locat = Provider.of<BaseLocation>(context, listen: false).baseLocation;

    // MyTextFormField'lerden alınan değerleri haritaya ekle
    String locationNameDegeri = locationName.text;
    String ulkeDegeri = ulke.text;
    String ilDegeri = il.text;
    String ilceDegeri = ilce.text;
    String mahalleDegeri = mahalle.text;
    String sokakDegeri = sokak.text;
    String noDegeri = no.text;
    String adresDegeri =
        '$mahalleDegeri, $sokakDegeri No: $noDegeri, $ilceDegeri/$ilDegeri, $ulkeDegeri';

    // Yeni bir konum ekleyin
    locat['$locationNameDegeri'] = {
      'name': '$locationNameDegeri',
      'adres': adresDegeri,
      'lat': 0.0, // Lat ve Lng değerlerini gerektiğine göre güncelleyin
      'lang': 0.0,
    };
    // Ekleme işlemi tamamlandıktan sonra formu temizle
    _temizle();
    Navigator.pop(context);
    return true;
  }

  void latLong(String name) {
    locationService.getPlaceId(name);
  }

  bool popUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adresinize İsim Verin'),
          content: TextField(
            controller: locationName,
            // Buraya TextField ile ilgili özellikleri ekleyebilirsiniz
            decoration: InputDecoration(
              hintText: 'İsim',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                saveLocation(context);
                Navigator.pop(context);
              },
              child: Text('Tamam'),
            ),
          ],
        );
      },
    );
    return true;
  }

  void showCountry(BuildContext context) {
    showCountryPicker(
      context: context,
      //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
      exclude: <String>['KN', 'MF'],
      favorite: <String>['SE'],
      //Optional. Shows phone code before the country name.
      showPhoneCode: true,
      onSelect: (Country country) {
        print('Select country: ${country.name}');
        setState(() {
          countryName = country.name;
        });
      },
      // Optional. Sets the theme for the country list picker.
      countryListTheme: CountryListThemeData(
        // Optional. Sets the border radius for the bottomsheet.
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
        // Optional. Styles the text in the search field
        searchTextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 18,
        ),
      ),
    );
  }

  void _temizle() {
    ulke.clear();
    il.clear();
    ilce.clear();
    mahalle.clear();
    sokak.clear();
    no.clear();
  }
}
