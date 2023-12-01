import 'package:flutter/material.dart';
 
class PaymentCard {
  String cardName;
  String cardNumber;
 
  PaymentCard({required this.cardName, required this.cardNumber});
}
 
class PaymentProvider with ChangeNotifier {
  String cardName = "Card Name";
  String cardNumber = "Card Number";
  List<PaymentCard> cards = [];
 
  void updateVariable(String newValue) {
    cardName = newValue;
    notifyListeners();
  }
 
  void updateNumber(String newNumber) {
  if (newNumber.length >= 4) {
    String visiblePart = newNumber.substring(0, 4);
    String hiddenPart = '********';
    String lastPart = newNumber.substring(newNumber.length - 4);
    cardNumber = visiblePart + hiddenPart + lastPart;
  } else {
    print("Invalid card number format");
  }
 
  notifyListeners();
}
 
 
  void addCard(String cardName, String cardNumber) {
    cards.add(PaymentCard(cardName: cardName, cardNumber: cardNumber));
    notifyListeners();
  }
 
  void removeCard(int index) {
    if (index >= 0 && index < cards.length) {
      cards.removeAt(index);
      notifyListeners();
    }
  }
 
}