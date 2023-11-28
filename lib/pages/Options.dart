import 'package:flutter/material.dart';
import 'package:taxiapp/class/custom_icon.dart';

class Options extends StatefulWidget {
  const Options({Key? key}) : super(key: key);

  @override
  State<Options> createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  bool animalDeger = false;
  bool earsDeger = false;
  bool eyesDeger = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   iconTheme: IconThemeData(color: Colors.transparent),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/dtx.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
         Positioned(
  top: 35.0,
  left: 10.0,
  child: Container(
    width: 40.0,
    height: 40.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Color(0xfff2f2f2),
    ),
    child: IconButton(
      color: Colors.amber,
      icon: Icon(Icons.arrow_back_outlined),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  ),
),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 300.0,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xfff2f2f2),
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Evcil Hayvanım Var',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Switch(
                          value: animalDeger,
                          activeColor: Colors.orange,

                          onChanged: (bool value) {
                            setState(() {
                              animalDeger = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('İşitme Engelim Var',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Switch(
                          value: earsDeger,
                          activeColor: Colors.orange,
                          onChanged: (bool value) {
                            setState(() {
                              earsDeger = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Görme Engelim Var',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        Switch(
                          value: eyesDeger,
                          activeColor: Colors.orange,

                          onChanged: (bool value) {
                            setState(() {
                              eyesDeger = value;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text(
                              'Kaydet',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
