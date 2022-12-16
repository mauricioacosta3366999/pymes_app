import 'package:flutter/material.dart';
import 'package:pymes_app/appConfig.dart';
import 'package:pymes_app/pages/createDebt.dart';
import 'package:pymes_app/widgets/appBar.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/debtCard.dart';

class NewPay extends StatefulWidget {
  final String clientName;
  const NewPay({super.key, required this.clientName});

  @override
  State<NewPay> createState() => _NewPayState();
}

class _NewPayState extends State<NewPay> {
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
                  child: BasicButton(
                    text: 'Registrar pago',
                    onclick: () {},
                  )))
        ],
      ),
    );
  }
}
