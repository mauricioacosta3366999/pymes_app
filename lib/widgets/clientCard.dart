import 'package:flutter/material.dart';
import 'package:pymes_app/pages/clientDebts.dart';

import '../appConfig.dart';

class ClientCard extends StatelessWidget {
  final String clientName;
  final String clientDebt;
  const ClientCard(
      {super.key, required this.clientName, required this.clientDebt});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ClientDebts(
                      clientName: 'Alfredo',
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.025),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppConfig().shadowColor,
              spreadRadius: 0,
              blurRadius: 7,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
              stops: const [0.02, 0.02],
              colors: [AppConfig().succesColor, Colors.white]),
          borderRadius: BorderRadius.circular(20),
        ),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Container(
            padding: const EdgeInsets.only(left: 20),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(clientName),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(clientDebt),
          )
        ]),
      ),
    );
  }
}
