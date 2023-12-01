import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/app_color.dart';
import 'package:taxiapp/class/model/payment_model.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/add_credit_card.dart';
 
class Payment extends StatefulWidget {
  const Payment({super.key});
 
  @override
  State<Payment> createState() => _PaymentState();
}
 
class _PaymentState extends State<Payment> {
  bool isPressed = false;
 
  Future<void> _showDeleteConfirmationDialog(index) async {
  return showDialog<void>(
    context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Provider.of<ThemeNotifier>(context).isDarkMode == true ? AppColors.dark_theme.wigdetColor : Colors.white,
            title: const Text('Delete?'),
            content: const Text('Are you sure you want to delete this item?'),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () {
                    Provider.of<PaymentProvider>(context, listen: false).removeCard(index);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Delete',
                  )),
            ],
          );
        });
  }
 
          List<Widget> buildPaymentCards() {
          if (Provider.of<PaymentProvider>(context).cards.length != 0) {
            return [
              Text(
                'Kredi/Banka Kartlarım',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ];
          } else {
            return [
              Container(),
            ];
          }
        }
 
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove the shadow
          title: Text("Ödeme Yöntemlerim", style: TextStyle(color: Provider.of<ThemeNotifier>(context).isDarkMode == true ?Colors.white : Colors.black, fontSize: 20),),
          iconTheme:IconThemeData(color: Colors.amber),
        ),
        body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Credit_Card()),
                          )
                        },
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Provider.of<ThemeNotifier>(context).isDarkMode == true ? AppColors.dark_theme.wigdetColor :Colors.white,
                  boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 2))
                ],
                borderRadius: BorderRadius.circular(16)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.circlePlus, color: Colors.amber,),
                   
                    Text(
                      'Yeni Kart Ekle',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(FontAwesomeIcons.angleRight, color: Colors.amber,)
                  ],
                ),
              ),
            ),
 
            SizedBox(height: 20),
 
            ...buildPaymentCards(),
            Expanded(
              child: ListView.builder(
                itemCount: Provider.of<PaymentProvider>(context).cards.length,
                itemBuilder: (context, index) {
                  var card = Provider.of<PaymentProvider>(context).cards[index];
                  return Container(
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isPressed ? Colors.amber : Provider.of<ThemeNotifier>(context).isDarkMode == true ? AppColors.dark_theme.wigdetColor : Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isPressed = !isPressed;
                                  print(isPressed);
                                });
                              },
                              child: Text(
                                card.cardName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Kartı silme işlemi için dialogu göster
                                _showDeleteConfirmationDialog(index);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          children: [
                            Image.network("https://download.logo.wine/logo/Mastercard/Mastercard-Logo.wine.png", width: 32,),
                            SizedBox(width: 16),
                            Text(
                              card.cardNumber,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
 
          ],
        ),
      ),
    );
  }
}