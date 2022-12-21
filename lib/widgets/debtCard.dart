import 'package:flutter/material.dart';

import '../appConfig.dart';

class DebtCard extends StatelessWidget {
  final String details;
  final String total;
  final String date;
  final bool isPay;
  const DebtCard({
    super.key,
    required this.date,
    required this.details,
    required this.total,
    required this.isPay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: isPay
            ? LinearGradient(
                stops: const [0.02, 0.02],
                colors: [AppConfig().succesColor, Colors.white])
            : null,
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
                  child: Text(details)),
              Text(
                date,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Text(total, style: const TextStyle(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
