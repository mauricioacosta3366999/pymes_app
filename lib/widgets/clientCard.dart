import 'package:flutter/material.dart';
import 'package:pymes_app/pages/clientDebts.dart';

import '../appConfig.dart';

class ClientCard extends StatelessWidget {
  final String clientName;
  final String clientId;
  const ClientCard({
    super.key,
    required this.clientName,
    required this.clientId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientDebts(
                      clientName: clientName,
                      clientId: clientId,
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
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(0),
                child: Icon(
                  Icons.phone,
                  color: AppConfig().prymaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Icon(
                  Icons.whatsapp,
                  color: AppConfig().prymaryColor,
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
