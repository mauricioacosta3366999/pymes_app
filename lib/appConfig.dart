import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppConfig {
  final prymaryColor = const Color(0xff005439);
  final secundaryColor = Color.fromARGB(88, 0, 146, 112);
  final succesColor = const Color(0xffCFECCF);
  final errorColor = Colors.red[400];
  final buttonColor = const Color(0xff005439);
  final shadowColor = Colors.grey.withOpacity(0.3);

  showSnack(
    String text,
    int duration,
  ) {
    return SnackBar(
      duration: Duration(seconds: duration),
      content: Text(text),
      backgroundColor: Colors.red[400],
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  dateFormat({required DateTime date}) {
    final df = DateFormat('dd-MM-yyyy hh:mm a');
    return df.format(date);
  }

  currencyFormat(int value) {
    var formatter = NumberFormat.decimalPattern();
    String priceFormated = formatter.format(value).replaceAll(',', '.');
    return '$priceFormated Gs';
  }
}
