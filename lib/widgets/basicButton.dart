import 'package:flutter/material.dart';

import '../appConfig.dart';

class BasicButton extends StatelessWidget {
  final Function onclick;
  final String text;
  final bool? redButton;
  const BasicButton(
      {super.key, required this.onclick, required this.text, this.redButton});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onclick();
      },
      child: Container(
        decoration: BoxDecoration(
          color: redButton == true
              ? AppConfig().errorColor
              : AppConfig().buttonColor,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        height: 45,
        width: 150,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }
}
