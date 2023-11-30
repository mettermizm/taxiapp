import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:taxiapp/pages/payment.dart';

class Credit_Card extends StatefulWidget {
  const Credit_Card({Key? key});

  @override
  State<Credit_Card> createState() => _Credit_CardState();
}

class _Credit_CardState extends State<Credit_Card> {

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  String cardName = '';

  // Form key for CreditCardForm
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Keys for individual form fields
  final GlobalKey<FormFieldState<String>> cardNumberKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> expiryDateKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> cardHolderKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> cvvCodeKey =
      GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Yeni Kart Ekle",
          style: TextStyle(fontSize: 20),
        ),
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              isHolderNameVisible: true,
              onCreditCardWidgetChange: (CreditCardBrand brand) {
                // Callback for anytime credit card brand is changed
              },
            ),
        
            CreditCardForm(
              formKey: formKey,
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              cardNumberKey: cardNumberKey,
              cvvCodeKey: cvvCodeKey,
              expiryDateKey: expiryDateKey,
              cardHolderKey: cardHolderKey,
              onCreditCardModelChange: (CreditCardModel data) {
                setState(() {
                  cardNumber = data.cardNumber;
                  expiryDate = data.expiryDate;
                  cardHolderName = data.cardHolderName;
                  cvvCode = data.cvvCode;
                  isCvvFocused = data.isCvvFocused;
                });
              },
              obscureCvv: true,
              obscureNumber: true,
              isHolderNameVisible: true,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              enableCvv: true,
              cvvValidationMessage: 'Please input a valid CVV',
              dateValidationMessage: 'Please input a valid date',
              numberValidationMessage: 'Please input a valid number',
              cardNumberValidator: (String? cardNumber) {},
              expiryDateValidator: (String? expiryDate) {},
              cvvValidator: (String? cvv) {},
              cardHolderValidator: (String? cardHolderName) {},
              onFormComplete: () {
                // callback to execute at the end of filling card data
              },
              autovalidateMode: AutovalidateMode.always,
              disableCardNumberAutoFillHints: false,
              inputConfiguration: const InputConfiguration(
                cardNumberDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Number',
                  hintText: '**** **** **** ****',
                ),
                expiryDateDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Expired Date',
                  hintText: 'XX/XX',
                ),
                cvvCodeDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'CVV',
                  hintText: 'XXX',
                ),
                cardHolderDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Card Holder',
                ),
                cardNumberTextStyle: TextStyle(
                  fontSize: 10,
                  //color: Colors.black,
                ),
                cardHolderTextStyle: TextStyle(
                  fontSize: 10,
                  //color: Colors.black,
                ),
                expiryDateTextStyle: TextStyle(
                  fontSize: 10,
                  //color: Colors.black,
                ),
                cvvCodeTextStyle: TextStyle(
                  fontSize: 10,
                  //color: Colors.black,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Name',
                      ),
                      // controller: cardNameController,
                      onChanged: (value) {
                        setState(() {
              cardName = value;
              print(cardName);
                        });
                      },
                    ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12)
                ),
                onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Payment()),
                          );
                },
                child: Text("Kartımı Kaydet", style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
