import 'package:flutter/material.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/models/debtsListModel.dart';
import 'package:pymes_app/pages/createDebt.dart';
import 'package:pymes_app/pages/newPay.dart';
import 'package:pymes_app/widgets/debtCard.dart';

import '../appConfig.dart';
import '../widgets/appBar.dart';
import '../widgets/basicButton.dart';

class ClientDebts extends StatefulWidget {
  final String clientId;
  final String clientName;
  const ClientDebts(
      {super.key, required this.clientName, required this.clientId});

  @override
  State<ClientDebts> createState() => _ClientDebtsState();
}

class _ClientDebtsState extends State<ClientDebts> {
  List<DebtsListModel> debtsLIst = [];
  bool loading = true;
  DebtsListModel newData = DebtsListModel();

  @override
  void initState() {
    getClientDebts();
    super.initState();
  }

  getClientDebts() async {
    setState(() => loading = true);
    debtsLIst = await Endpoints().getClientDebtsList(clientId: widget.clientId);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: MyAppBar(tittle: widget.clientName)),
      body: loading
          ? Center(
              child: CircularProgressIndicator(
                color: AppConfig().secundaryColor,
              ),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              debtsLIst.isEmpty
                                  ? 'No tiene registros'
                                  : 'Registros',
                              style: const TextStyle(fontSize: 27),
                            ),
                          ),
                          for (var i = 0; i < debtsLIst.length; i++)
                            DebtCard(
                              clientId: widget.clientId,
                              clientName: widget.clientName,
                              id: debtsLIst[i].id!,
                              isPay: debtsLIst[i].details == 'Pago agregado'
                                  ? true
                                  : false,
                              date: AppConfig()
                                  .dateFormat(date: debtsLIst[i].created!),
                              details: debtsLIst[i].details!,
                              total: AppConfig()
                                  .currencyFormat(debtsLIst[i].total!),
                            )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.09,
                        width: MediaQuery.of(context).size.width,
                        color: AppConfig().secundaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            BasicButton(
                              text: 'Agregar pago',
                              onclick: () {
                                getNewData(true);
                              },
                            ),
                            BasicButton(
                              text: 'Agregar deuda',
                              onclick: () async {
                                getNewData(false);
                              },
                            ),
                          ],
                        )))
              ],
            ),
    );
  }

  getNewData(bool isPay) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => isPay
                ? NewPay(
                    clientName: widget.clientName,
                    clientId: widget.clientId,
                  )
                : CreateDebt(
                    clientId: widget.clientId,
                    clienName: widget.clientName,
                  ))).then((value) {
      if (value != null) {
        debtsLIst.add(value);
        setState(() {});
      }
    });
  }
}
