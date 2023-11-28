import 'package:flutter/material.dart';

class FavoriteAdres extends StatefulWidget {
  const FavoriteAdres({Key? key}) : super(key: key);

  @override
  State<FavoriteAdres> createState() => _FavoriteAdresState();
}

// enum SingingCharacter { ev1, ev2, is1, is2, yeniAdres, yeniAdres2,yeniAdres3,yeniAdres4 }
List<String> adresTypes = ['Ev Adresi 1', 'Ev Adresi 2', 'İş Adresi 1', 'İş Adresi 2'];

class _FavoriteAdresState extends State<FavoriteAdres> {
  // SingingCharacter? _character = SingingCharacter.ev1;
  String? _selectedAdresType;

  // Örnek veri
  final List<Map<String, String>> adresler = [
    {
      'title': 'Ev Adresi 1',
      'subtitle': 'Kazimdirik Mah 501.sk.',
    },
    {
      'title': 'Ev Adresi 2',
      'subtitle': 'Memurevleri Mah 211.sk.',
    },
    {
      'title': 'İş Adresi 1',
      'subtitle': 'AOSB Mah 10049.sk.',
    },
    {
      'title': 'İş Adresi 2',
      'subtitle': 'AOSB Mah 10043.sk.',
    },
  ];

  // Modal için kontrolcüler (controllers)
  final TextEditingController adresTipiController = TextEditingController();
  final TextEditingController mahalleController = TextEditingController();
  final TextEditingController sokakController = TextEditingController();
  final TextEditingController noController = TextEditingController();
  final TextEditingController katController = TextEditingController();
  final TextEditingController daireNoController = TextEditingController();
  final TextEditingController ilController = TextEditingController();
  final TextEditingController ilceController = TextEditingController();
  final TextEditingController postaKoduController = TextEditingController();
  final TextEditingController telefonNumarasiController =
      TextEditingController();

  // Modal açılıp kapanması için kontrolcü (controller)
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //bool _modalOpen = false;
  void temizle() {
    adresTipiController.clear();
    mahalleController.clear();
    sokakController.clear();
    noController.clear();
    katController.clear();
    daireNoController.clear();
    ilController.clear();
    ilceController.clear();
    postaKoduController.clear();
    telefonNumarasiController.clear();
  }

  void kaydet() {
    final Map<String, String> yeniAdres = {
      'title': adresTipiController.text,
      'subtitle': mahalleController.text,
    };

    setState(() {
      adresler.add(yeniAdres);
    });
  }

  @override
  void dispose() {
    // Kontrolcüleri temizle
    adresTipiController.dispose();
    mahalleController.dispose();
    sokakController.dispose();
    noController.dispose();
    katController.dispose();
    daireNoController.dispose();
    ilController.dispose();
    ilceController.dispose();
    postaKoduController.dispose();
    telefonNumarasiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Favori Adreslerim',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: adresler.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(adresler[index]['title']!),
            subtitle: Text(adresler[index]['subtitle']!),
            leading: Radio<String>(
              activeColor: Colors.orange,
              value: adresler[index]['title']!,
              groupValue: _selectedAdresType,
              onChanged: (String? value) {
                setState(() {
                  _selectedAdresType = value;
                });
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  color: Colors.orange,
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Edit iconuna basıldığında modalı aç
                    _openModal(context);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          _openModal(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  // Modalı açan metod
  void _openModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.9,
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: adresTipiController,
                        decoration: InputDecoration(labelText: 'Adres Tipi'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen adres tipini giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: mahalleController,
                        decoration: InputDecoration(labelText: 'Mahalle'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen mahalle bilgisini giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: sokakController,
                        decoration: InputDecoration(labelText: 'Sokak'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Sokak bilgisini giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: noController,
                        decoration: InputDecoration(labelText: 'Numara'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Apartman Numarasını giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: katController,
                        decoration: InputDecoration(labelText: 'Kat'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Kat Bilgisini giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: daireNoController,
                        decoration: InputDecoration(labelText: 'Daire No'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Daire No giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: ilController,
                        decoration: InputDecoration(labelText: 'İl'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen İl bilgisini giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: ilceController,
                        decoration: InputDecoration(labelText: 'İlçe'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen İlçe bilgisini giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: postaKoduController,
                        decoration: InputDecoration(labelText: 'Posta Kodu'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Posta Kodunuzu giriniz';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: telefonNumarasiController,
                        decoration: InputDecoration(labelText: 'Cep Telefonu'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Lütfen Cep Telefonu Numaranızı  giriniz';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              temizle();
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  'Vazgeç',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Başarıyla kaydedildi'),
                                  ),
                                );
                                kaydet();

                                Navigator.of(context).pop();
                              }
                            },
                            child: Container(
                              width: 100,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  'Kaydet',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
