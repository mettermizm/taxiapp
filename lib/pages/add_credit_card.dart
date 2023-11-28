import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class Credit_Card extends StatefulWidget {
  const Credit_Card({Key? key});

  @override
  State<Credit_Card> createState() => _Credit_CardState();
}

class _Credit_CardState extends State<Credit_Card> {
  // Define your credit card details (replace with your actual data)
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = 'John Doe';
  String cvvCode = '205';
  bool isCvvFocused = false;

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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Yeni Kart Ekle",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.amber),
      ),
      body: Column(
        children: [
          // Your existing CreditCardWidget
          CreditCardWidget(
            cardNumber: cardNumber,
            expiryDate: expiryDate,
            cardHolderName: cardHolderName,
            cvvCode: cvvCode,
            showBackView: isCvvFocused,
            onCreditCardWidgetChange: (CreditCardBrand brand) {
              // Callback for anytime credit card brand is changed
            },
          ),
          // CreditCardForm
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
            onCreditCardModelChange: (CreditCardModel data) {},
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
                color: Colors.black,
              ),
              cardHolderTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              expiryDateTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
              cvvCodeTextStyle: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
