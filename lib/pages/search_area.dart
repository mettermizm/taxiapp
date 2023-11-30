import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/map_page.dart';

class SearchArea extends StatefulWidget {
  const SearchArea({Key? key}) : super(key: key);

  @override
  State<SearchArea> createState() => _SearchAreaState();
}

class _SearchAreaState extends State<SearchArea> {
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

  Map<String, dynamic> _baseLocation = {
    'saat_kulesi': {
      'name': 'Saat Kulesi',
      'lat': 38.41170946334618,
      'lang': 27.128457612315454
    },
    'adnan_menderes_havalimani': {
      'name': 'Adnan Menderes Havalimanı',
      'lat': 38.2921319298416,
      'lang': 27.148907594283028
    },
    'kültürpark': {
      'name': 'Kültürpark',
      'lat': 38.42869959642496,
      'lang': 27.14531281039571
    },
    'sagopa_camii': {
      'name': 'Sagopa Kajmer Camii',
      'lat': 38.415882284869056,
      'lang': 27.181388568065596
    },
    'mini_mutfak_cafe': {
      'name': 'Mini Mutfak Cafe',
      'lat': 38.405854490962575,
      'lang': 27.117985539230176
    },
    'mithatpasa_lisesi': {
      'name': 'Mithatpaşa Mesleki ve Teknik Anadolu Lisesi',
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
                    color: Provider.of<ThemeNotifier>(context)
                        .isDarkMode == true
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
                      Text("Ev Adresi Ekle",style: TextStyle(color: Colors.black),),
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
                      Text("İş Adresi Ekle", style: TextStyle(color: Colors.black),),
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
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('adnan_menderes_havalimani'),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('kültürpark'),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('sagopa_camii'),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            gestureDetector('mini_mutfak_cafe'),
            Divider(
              color: Colors.grey,
              thickness: 1,
              height: 20,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.streetview, size: 18, color: Colors.grey),
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
          Icon(Icons.fmd_good, size: 18, color: Colors.grey),
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
}
