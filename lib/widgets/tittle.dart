import 'package:flutter/material.dart';

import '../appConfig.dart';

class PrincipalTitle extends StatelessWidget {
  final String text;
  const PrincipalTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            text,
            style: TextStyle(
                color: AppConfig().prymaryColor,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
