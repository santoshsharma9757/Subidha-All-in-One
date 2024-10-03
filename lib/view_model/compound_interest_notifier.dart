import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_string.dart';
import 'package:hamro_smart_life/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;
import 'package:nepali_utils/nepali_utils.dart';

class CompoundInterestNotifier extends ChangeNotifier {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  picker.NepaliDateTime? _loanTakenDate;
  picker.NepaliDateTime? _paymentDate;
  get loanTakenDate => _loanTakenDate;

  set loanTakenDate(value) => _loanTakenDate = value;

  get paymentDate => _paymentDate;

  set paymentDate(value) => _paymentDate = value;

  String? _loanTakenDateUI;
  String? _paymentDateUI;
  get loanTakenDateUI => _loanTakenDateUI;

  set loanTakenDateUI(value) => _loanTakenDateUI = value;

  get paymentDateUI => _paymentDateUI;

  set paymentDateUI(value) => _paymentDateUI = value;

  double? _totalAmount;
  double? _interest;
  String? _timePeriod;
  get totalAmount => _totalAmount;

  set totalAmount(value) => _totalAmount = value;

  get interest => _interest;

  set interest(value) => _interest = value;

  get timePeriod => _timePeriod;

  set timePeriod(value) => _timePeriod = value;

  Future<void> selectDate(BuildContext context,
      {required bool isLoanDate}) async {
    NepaliUtils().language = Language.english;
    picker.NepaliDateTime? selectedDate = await picker.showMaterialDatePicker(
      context: context,
      initialDate: picker.NepaliDateTime.now(),
      firstDate: picker.NepaliDateTime(2000),
      lastDate: picker.NepaliDateTime(2090),
      locale: const Locale('en', 'US'),
    );

    if (selectedDate != null) {
      if (isLoanDate) {
        String formattedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.parse('$selectedDate'));
        _loanTakenDate = selectedDate;
        _loanTakenDateUI = formattedDate;
      } else {
        String formattedDate =
            DateFormat('yyyy-MM-dd').format(DateTime.parse('$selectedDate'));
        _paymentDate = selectedDate;
        _paymentDateUI = formattedDate;
      }
    }

    notifyListeners();
  }

  void calculateCompoundInterest(BuildContext context) {
    if (_loanTakenDate == null || _paymentDate == null) {
      AppUtils.snackBar(CIString.dateNotSelectedValidation, context);
      return;
    }

    if (_loanTakenDate != null && _paymentDate != null) {
      // Check if payment date is earlier than loan taken date
      if (_paymentDate!.isBefore(_loanTakenDate!)) {
        AppUtils.snackBar(CIString.dateValidation, context);
        return;
      }

      double principal = double.parse(principalController.text);
      double monthlyRate = double.parse(rateController.text) / 100;

      // Calculate the difference in years, months, and days
      int yearDiff = _paymentDate!.year - _loanTakenDate!.year;
      int monthDiff = _paymentDate!.month - _loanTakenDate!.month;
      int dayDiff = _paymentDate!.day - _loanTakenDate!.day;

      // Adjust the day difference if negative
      if (dayDiff < 0) {
        monthDiff -= 1;
        dayDiff +=
            NepaliDateTime(_loanTakenDate!.year, _loanTakenDate!.month + 1, 1)
                .subtract(const Duration(days: 1))
                .day;
      }
      // Adjust the month difference if negative
      if (monthDiff < 0) {
        yearDiff -= 1;
        monthDiff += 12;
      }

      int totalMonths = yearDiff * 12 + monthDiff;
      int totalDays = totalMonths * 30 + dayDiff;

      // Step 1: Calculate interest for complete years
      double amountForYears = principal * pow(1 + (monthlyRate * 12), yearDiff);

      // Step 2: Calculate interest for remaining months and days
      double amountForMonthsAndDays =
          amountForYears * (1 + (totalDays * monthlyRate * 12 / 360));

      // Final interest and total amount
      _interest = (amountForMonthsAndDays - principal).roundToDouble();
      _totalAmount = amountForMonthsAndDays.roundToDouble();

      // Format the time period
      _timePeriod =
          '$yearDiff ${CIString.year} $monthDiff ${CIString.month}, $dayDiff ${CIString.day}';
    }
    notifyListeners();
  }

  clearSelectedValue() {
    _loanTakenDate == null;
    _paymentDate = null;
    _loanTakenDateUI = "";
    _paymentDateUI = "";
    principalController.clear();
    rateController.clear();
    _timePeriod = null;
    _interest = null;
    _totalAmount = null;
  }
}
