import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/app_color.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/drivers.dart';
import 'package:taxiapp/pages/nearest_Taxis.dart';
import 'package:taxiapp/pages/payment.dart';
import 'package:taxiapp/pages/search_area.dart';
import 'package:taxiapp/class/model/taxi_people_model.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  String? konum;
  BottomBar({
    Key? key,
    this.konum,
  }) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  bool isCashSelected = false;
  bool isMasterCardSelected = false;

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Gitmek İstediğiniz Konum:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  widget.konum ?? 'Nereye Gitmek İstersiniz?',
                  style: TextStyle(fontSize: 16, color: Provider.of<ThemeNotifier>(context).isDarkMode == true ? Colors.white : Colors.black,),
                ),
                SizedBox(height: 20),
                Text(
                  "Seçilen Araç:",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Provider.of<ThemeNotifier>(context).isDarkMode == true ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
SizedBox(height: 15.0,),

                Text(
                  '${Provider.of<DataProvider>(context).selectedCar}',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold,color: Provider.of<ThemeNotifier>(context).isDarkMode == true ? Colors.white : Colors.black,),
                ),
SizedBox(height: 15.0,),

                Text(
                  "${Provider.of<DataProvider>(context).selectedPrice} TL/Km.",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Provider.of<ThemeNotifier>(context).isDarkMode == true ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
SizedBox(height: 15.0,),
                Text('Taksi Çağırma İşlemini Onaylıyor Musunuz ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hayır'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackbar();
              },
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar() {
    final snackBar = SnackBar(
      content: Text('Taksi başarıyla çağırıldı!'),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void selectCash() {
    setState(() {
      isCashSelected = !isCashSelected;
      isMasterCardSelected = false;
    });
    // Burada nakit seçildiğinde yapılacak işlemler eklenebilir
  }

  void selectMasterCard() {
    setState(() {
      isCashSelected = false;
      isMasterCardSelected = true;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Payment()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Provider.of<ThemeNotifier>(context).isDarkMode ==
                true
                ? AppColors.dark_theme.wigdetColor : Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: Offset(0, 2))
              ]),
          height: 40,
          width: 360,
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Provider.of<ThemeNotifier>(context).isDarkMode ==
                  true
                  ? Colors.amber : Colors.amber,
                ),
                child: Icon(
                  Icons.search,
                  color: Provider.of<ThemeNotifier>(context).isDarkMode ==
                  true
                  ? AppColors.dark_theme.wigdetColor : Colors.white,
                ),
              ),/*color: Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? Colors.white : Colors.black,*/
                Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchArea()),
                      );
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          //filled: true, // Arka plan rengini etkinleştirmek için
                          /*fillColor:
                              Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? Colors.black
                                  : Colors.white,*/
                          border: OutlineInputBorder(
                            // Sınır stilini ayarlamak için
                            borderRadius:
                                BorderRadius.circular(8), // Kenar yuvarlaklığı
                            borderSide: BorderSide
                                .none, // Sınır çizgisini kaldırmak için
                          ),
                          hintText: widget.konum ?? 'Nereye Gitmek İstersiniz?',
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              color: Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? AppColors.dark_theme.wigdetColor : Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36), topRight: Radius.circular(36)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 8,
                    blurRadius: 5,
                    offset: Offset(0, 2))
              ]),
          padding: EdgeInsets.only(top: 32, right: 16, left: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Taxis()),
                          )
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 2))
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "En Yakın Taksiler",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .isDarkMode ==
                                                    true
                                                ? Colors.black
                                                : Colors.black),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: FractionalTranslation(
                                  translation: Offset(0.11, 0.0),
                                  child: Image.asset(
                                    "assets/car.png",
                                    width: 100,
                                    height: 60,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Peoples()))
                        },
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(32),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 2))
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Şoförünü Seç",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color:
                                            Provider.of<ThemeNotifier>(context)
                                                        .isDarkMode ==
                                                    true
                                                ? Colors.black
                                                : Colors.black),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: FractionalTranslation(
                                  translation: Offset(-0.3, 0.0),
                                  child: Image.asset(
                                    "assets/people.png",
                                    width: 49,
                                    height: 100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color:  Provider.of<ThemeNotifier>(context)
                                                        .isDarkMode ==
                                                    true
                                                ? AppColors.dark_theme.wigdetColor
                                                : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 2))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Seçilen Araç:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .isDarkMode ==
                                          true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16),
                            ),
                            Text(
                              '${Provider.of<DataProvider>(context).selectedCar}',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold, color: Provider.of<ThemeNotifier>(context).isDarkMode == true ? Colors.white : Colors.black,),
                            ),
                            Text(
                              "${Provider.of<DataProvider>(context).selectedPrice} TL/Km.",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .isDarkMode ==
                                          true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Ödeme Yöntemleri",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Provider.of<ThemeNotifier>(context)
                                              .isDarkMode ==
                                          true
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: selectCash,
                                  child: Container(
                                    width: 48,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: isCashSelected ? Colors.green
                                          : Provider.of<ThemeNotifier>(
                                                  context)
                                                  .isDarkMode == true
                                              ? AppColors.dark_theme.wigdetColor
                                              : Colors.white,
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.7),
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Nakit",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Provider.of<ThemeNotifier>(
                                                          context)
                                                      .isDarkMode ==
                                                  true
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 12),
                                    )),
                                  ),),
                                  SizedBox(width: 12),
                                  Container(
                                    width: 48,
                                    height: 28,
                                    decoration: BoxDecoration(
                                        color: Provider.of<ThemeNotifier>(
                                                  context)
                                                  .isDarkMode == true
                                              ? AppColors.dark_theme.wigdetColor
                                              : Colors.white,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.7),
                                              spreadRadius: 1,
                                              blurRadius: 3,
                                              offset: Offset(0, 1))
                                        ]),
                                    child: Center(
                                      child: Text(
                                      "MasterCard",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Provider.of<ThemeNotifier>(
                                                  context)
                                                  .isDarkMode == true
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 8),
                                    )
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => {
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchArea()),
                  )*/
                  _showConfirmationDialog(),
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 1))
                      ]),
                  child: Center(
                    child: Text(
                      'Taksi Çağır',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color:
                              Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? Colors.black
                                  : Colors.black,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
