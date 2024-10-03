import 'package:flutter/material.dart';

class SimpleInterestNotifier extends ChangeNotifier {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  double _result = -1;
  double get result => _result;

  double _totalAmount = -1;
 double get totalAmount => _totalAmount;

  calculateSimpleInterest() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double time = double.parse(timeController.text);
    _result = (principal * rate * time) / 100;
    _totalAmount = _result + principal;
    notifyListeners();
  }

  clearSelectedValue() {
    principalController.clear();
    rateController.clear();
    timeController.clear();
    _result = -1;
  }
}
