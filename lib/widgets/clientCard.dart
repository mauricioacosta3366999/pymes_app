import 'package:flutter/material.dart';
import 'package:pymes_app/pages/clientDebts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../appConfig.dart';

class ClientCard extends StatefulWidget {
  final String clientName;
  final String clientId;
  final String phone;
  const ClientCard({
    super.key,
    required this.clientName,
    required this.phone,
    required this.clientId,
  });

  @override
  State<ClientCard> createState() => _ClientCardState();
}

class _ClientCardState extends State<ClientCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientDebts(
                      clientName: widget.clientName,
                      clientId: widget.clientId,
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
            child: Text(widget.clientName),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _launchCaller();
                },
                child: Icon(
                  Icons.phone,
                  color: AppConfig().prymaryColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _launchWhatsapp();
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(
                    Icons.whatsapp,
                    color: AppConfig().prymaryColor,
                  ),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }

  _launchCaller() async {
    var url = "tel:${widget.phone}";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchWhatsapp() async {
    try {
      String text = "Esto es un mensaje de prueba";
      String url =
          "https://wa.me/595${widget.phone}?text=${Uri.encodeFull(text)}";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("contacto error catch"),
        ),
      );
    }
  }
}
