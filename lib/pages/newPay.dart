import 'package:flutter/material.dart';
import 'package:pymes_app/appConfig.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/models/debtsListModel.dart';
import 'package:pymes_app/pages/createDebt.dart';
import 'package:pymes_app/widgets/appBar.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/basicInput.dart';
import 'package:pymes_app/widgets/debtCard.dart';

class NewPay extends StatefulWidget {
  final String clientName;
  final String clientId;
  const NewPay({super.key, required this.clientName, required this.clientId});

  @override
  State<NewPay> createState() => _NewPayState();
}

class _NewPayState extends State<NewPay> {
  var payController = TextEditingController();
  bool loading = false;

  payRegister() async {
    if (payController.text.isNotEmpty) {
      setState(() => loading = true);
      var clearNum = payController.text.replaceAll('.', '');
      DebtsListModel newData = await Endpoints().debtRegister(
          details: 'Pago agregado',
          total: int.parse(clearNum),
          clientId: widget.clientId);
      print(newData);
      setState(() => loading = false);
      if (newData.id != null) {
        Navigator.pop(context, newData);
      }
    }
  }

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
                  children: [
                    const Text('Agregar pago'),
                    Text(AppConfig().dateFormat(date: DateTime.now()))
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Registrar pago',
                  style: TextStyle(fontSize: 27),
                ),
              ),
              const Text(
                'El pago registrado será lo que se descontará de la cuenta total del cliente',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BasicInput(
                    inputType: TextInputType.number,
                    needcurrencyFormat: true,
                    controller: payController,
                    icon: const Icon(Icons.monetization_on_outlined),
                    text: 'Precio'),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: AppConfig().secundaryColor,
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : BasicButton(
                          text: 'Registrar pago',
                          onclick: () {
                            payRegister();
                          },
                        )))
        ],
      ),
    );
  }
}
