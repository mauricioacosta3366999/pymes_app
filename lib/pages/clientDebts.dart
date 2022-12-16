import 'package:flutter/material.dart';
import 'package:pymes_app/pages/createDebt.dart';
import 'package:pymes_app/pages/newPay.dart';
import 'package:pymes_app/widgets/debtCard.dart';

import '../appConfig.dart';
import '../widgets/appBar.dart';
import '../widgets/basicButton.dart';

class ClientDebts extends StatefulWidget {
  final String clientName;
  const ClientDebts({super.key, required this.clientName});

  @override
  State<ClientDebts> createState() => _ClientDebtsState();
}

class _ClientDebtsState extends State<ClientDebts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: MyAppBar(tittle: widget.clientName)),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                color: AppConfig().secundaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [Text('Nueva deduda'), Text('12/21/2003')],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView(
                  children: [for (var i = 0; i < 10; i++) const DebtCard()],
                ),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BasicButton(
                        text: 'Nuevo abono',
                        onclick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NewPay(
                                        clientName: 'cliente Name',
                                      )));
                        },
                      ),
                      BasicButton(
                        text: 'Nueva deuda',
                        onclick: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CreateDebt()));
                        },
                      ),
                    ],
                  )))
        ],
      ),
    );
  }
}
