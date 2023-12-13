import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/base_location.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/location/home_location.dart';
import 'package:taxiapp/pages/map_page.dart';

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
                // List<Prediction> suggestions = await _getSuggestions(value);
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EvAdresiKaydetSayfasi()));
                  },
                  child: Container(
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
              height: 12,
            ),
            buildLocationButtons(),
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

  Widget buildLocationButtons() {
    return Expanded(
      child: Consumer<BaseLocation>(
        builder: (context, baseLocation, child) {
          List<String> locations = baseLocation.baseLocation.keys.toList();

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              //print('${locations.length}    LOCATİONS LENGTH');
              final locationKey = locations[index];
              final locationData = baseLocation.baseLocation[locationKey];

              return Column(
                children: [
                  SizedBox(height: 20),
                  Consumer<BaseLocation>(
                    builder: (context, baseLocation, child) {
                      // Burada gestureDetector'ı da Consumer içine alıyoruz
                      return gestureDetector(locationKey, locationData);
                    },
                  ),
                  Divider(
                    color:
                        Provider.of<ThemeNotifier>(context).isDarkMode == true
                            ? Colors.amber
                            : Colors.grey,
                    thickness: 1,
                    height: 20,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  GestureDetector gestureDetector(
      String title, Map<String, dynamic> locationData) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(
              baslangic: locationData,
              marker: locationData,
            ),
          ),
        );
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
            locationData['name'],
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
