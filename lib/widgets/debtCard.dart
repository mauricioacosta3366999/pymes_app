import 'package:flutter/material.dart';

import '../appConfig.dart';

class DebtCard extends StatelessWidget {
  const DebtCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppConfig().shadowColor,
            spreadRadius: 0,
            blurRadius: 7,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const Text(
                      'estos son algunos de los productos de la deuda')),
              const Text(
                '12/21/1212',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Text('120.000 Gs',
              style: TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
