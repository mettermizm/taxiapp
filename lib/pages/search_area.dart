import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/map_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchArea extends StatefulWidget {
  const SearchArea({Key? key}) : super(key: key);

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
  final String key = 'AIzaSyDVmWA_B1R1eetTVJp_pMzfG6HCIT2S9is';
  final _places =
      GoogleMapsPlaces(apiKey: "AIzaSyDVmWA_B1R1eetTVJp_pMzfG6HCIT2S9is");
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<List<Prediction>> _getSuggestions(String input) async {
    PlacesAutocompleteResponse response = await _places.autocomplete(input);
    if (response.isOkay) {
      return response.predictions;
    }
    return [];
  }

  Map<String, dynamic> _baseLocation = {
    'saat_kulesi': {
      'name': 'İzmir Saat Kulesi',
      "adres" : 'Kemeraltı Çarşısı, 35360 Konak/İzmir',
      'lat': 38.41170946334618,
      'lang': 27.128457612315454
    },
    'adnan_menderes_havalimani': {
      'name': 'Adnan Menderes Havalimanı',
      "adres":'Dokuz Eylül, 35410 Gaziemir/İzmir',
      'lat': 38.2921319298416,
      'lang': 27.148907594283028
    },
    'kültürpark': {
      'name': 'Kültürpark İzmir',
      'adres' : 'Mimar Sinan, Şair Eşref Blv. No.50, 35220 Konak/İzmir',
      'lat': 38.42869959642496,
      'lang': 27.14531281039571
    },
    'camii': {
      'name': 'Konak Cami',
      'adres':'Konak, İzmir Valiliği İç yolu No:4, 35250 Konak/İzmir',
      'lat': 38.415882284869056,
      'lang': 27.181388568065596
    },
    'mini_mutfak_cafe': {
      'name': 'Mini Mutfak Cafe',
      'adres': 'Kılıç Reis, 320. Sk. no:5A, 35280 Konak/İzmir',
      'lat': 38.405854490962575,
      'lang': 27.117985539230176
    },
    'mithatpasa_lisesi': {
      'name': 'Mithatpaşa Mesleki ve Teknik Anadolu Lisesi',
      'adres':'Küçükyalı Mah, Mithatpaşa Cd. No:469, 35280 Konak/İzmir',
      'lat': 38.40715514257953,
      'lang': 27.10742308105152
    },
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(4),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove the shadow
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: Icon(
                    Icons.close,
                    color:
                        Provider.of<ThemeNotifier>(context).isDarkMode == true
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              focusNode: _focusNode,
              decoration: InputDecoration(
                  hintText: 'Nereye gitmek istersiniz?',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.amber,
                    size: 30,
                  ),
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.amber,
                  )),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.amber))),
              onChanged: (value) async {
                List<Prediction> suggestions = await _getSuggestions(value);
                // Bu kısımda önerileri kullanıcıya göstermek için bir widget güncellemesi yapabilirsiniz.
              },
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 55,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3))
                      ]),
                  child: Center(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add),
                      ),
                      Text(
                        "Ev Adresi Ekle",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 55,
                  width: 170,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.amber,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3))
                      ]),
                  child: Center(
                      child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.add),
                      ),
                      Text(
                        "İş Adresi Ekle",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('saat_kulesi'),
            Divider(
              color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                  ? Colors.amber
                  : Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('adnan_menderes_havalimani'),
            Divider(
              color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                  ? Colors.amber
                  : Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('kültürpark'),
            Divider(
              color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                  ? Colors.amber
                  : Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('camii'),
            Divider(
              color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                  ? Colors.amber
                  : Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('mini_mutfak_cafe'),
            Divider(
              color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                  ? Colors.amber
                  : Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.streetview,
                  size: 18,
                  color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                      ? Colors.amber
                      : Colors.grey,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Haritadan Seç",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector gestureDetector(String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyHomePage(
                      baslangic: _baseLocation['$title'],
                      marker: _baseLocation['$title'],
                    )));
      },
      child: Row(
        children: [
          Icon(
            Icons.fmd_good,
            size: 18,
            color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                ? Colors.amber
                : Colors.grey,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            _baseLocation['$title']['name'],
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> getDirections(
      String origin, String destination) async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$destination&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = {
      'bounds_ne': json['routes'][0]['bounds']['northeast'],
      'bounds_sw': json['routes'][0]['bounds']['southwest'],
      'start_location': json['routes'][0]['legs'][0]['start_location'],
      'end_location': json['routes'][0]['legs'][0]['end_location'],
      'polyline': json['routes'][0]['overview_polyline']['points'],
      'polyline_decoded': PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
      'distance_text': json['routes'][0]['legs'][0]['distance']['text'],
      'distance_value': json['routes'][0]['legs'][0]['distance']['value'],
    };
    print("Distance: ${results['distance_text']}");

    // Mesafe sayısal değer olarak (metre cinsinden)
    print("Distance Value: ${results['distance_value']}");

    double distance =
        double.parse(results['distance_value'].toString()) / 1000.0;
    double costPerKilometer = 19.0;
    results['cost'] = distance * costPerKilometer;

    print("Distance: ${results['distance_text']}");
    print("Cost: ${results['cost']} TL");
    print(results);
    return results;
  }
}
