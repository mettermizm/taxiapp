import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key});

  @override
  State<Help> createState() => _HelpState();
}

enum SingingCharacter { ev1, ev2, is1, is2 }

class _HelpState extends State<Help> {
  //final SingingCharacter? _character = SingingCharacter.ev1;

  Map<SingingCharacter, String> adresDetails = {
    SingingCharacter.ev1: 'Çünkü Neden Olmasın. ',
    SingingCharacter.ev2: 'Neden Olsun.',
    SingingCharacter.is1: 'Onu Söyleyemiyoruz Malesef',
    SingingCharacter.is2: 'Çok Soru Sorma.',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            'Sıkça Sorulan Sorular',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
          SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: adresDetails.length,
            itemBuilder: (context, index) {
              SingingCharacter character = adresDetails.keys.elementAt(index);
              return ExpansionTile(
                title: ListTile(
                  title: Text(_getAdresTitle(character)),
                  //subtitle: Text(adresDetails[character] ?? ''),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0), // Alt boşluğu ayarlayın
                          child: Text(adresDetails[character] ?? ''),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  String _getAdresTitle(SingingCharacter character) {
    switch (character) {
      case SingingCharacter.ev1:
        return 'Neden Biz';
      case SingingCharacter.ev2:
        return 'Neden Siz';
      case SingingCharacter.is1:
        return 'Neden Onlar';
      case SingingCharacter.is2:
        return 'Soruyorum Neden';
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: Help(),
  ));
}
