import 'package:flutter/material.dart';

import '../appConfig.dart';

class MyAppBar extends StatelessWidget {
  final String tittle;
  const MyAppBar({super.key, required this.tittle});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(tittle), backgroundColor: AppConfig().prymaryColor);
  }
}
