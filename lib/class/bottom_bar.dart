import 'package:flutter/material.dart';
import 'package:taxiapp/pages/drivers.dart';
import 'package:taxiapp/pages/nearest_Taxis.dart';
import 'package:taxiapp/pages/drivers.dart';
import 'package:taxiapp/pages/search_area.dart';
 
class BottomBar extends StatefulWidget {
  String? konum;
  BottomBar({Key? key, this.konum,}) : super(key: key);
 
  @override
  State<BottomBar> createState() => _BottomBarState();
}
 
class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.white,
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
                  color: Colors.amber,
                ),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
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
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: widget.konum ?? 'Nereye Gitmek İstersiniz?',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
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
                color: Colors.white,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
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
                      color: Colors.white,
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
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Text(
                                "Toyota Corolla Hatchback",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "15 TL/Km.",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
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
                                  fontWeight: FontWeight.w600, fontSize: 13),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 48,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      color:
                                          Color.fromARGB(255, 207, 204, 204),
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
                                    "Nakit",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  )),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width: 48,
                                  height: 28,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
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
                                        fontSize: 8, color: Colors.red),
                                  )),
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
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SearchArea()),
                        )
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
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