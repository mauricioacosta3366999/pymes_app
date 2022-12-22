import 'package:flutter/material.dart';
import 'package:pymes_app/appConfig.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/pages/clientDebts.dart';
import 'package:pymes_app/widgets/appBar.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/basicInput.dart';

class DebtEdit extends StatefulWidget {
  final String clientName;
  final String clientId;
  final String detail;
  final String price;
  final String debtId;
  const DebtEdit(
      {super.key,
      required this.clientName,
      required this.clientId,
      required this.detail,
      required this.price,
      required this.debtId});

  @override
  State<DebtEdit> createState() => _DebtEditState();
}

class _DebtEditState extends State<DebtEdit> {
  var detailController = TextEditingController();
  var priceController = TextEditingController();
  bool loading = false;

  @override
  void initState() {
    detailController.text = widget.detail;
    priceController.text = widget.price.replaceAll(' Gs', '');
    setState(() {});
    super.initState();
  }

  screenMove() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ClientDebts(
                clientName: widget.clientName, clientId: widget.clientId)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return screenMove();
      },
      child: Scaffold(
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
                      const Text('Editar registro'),
                      Text(AppConfig().dateFormat(date: DateTime.now()))
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Editar registro',
                    style: TextStyle(fontSize: 27),
                  ),
                ),
                const Text(
                  'Modificá los detalles y el precio de la deuda',
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BasicInput(
                      controller: detailController,
                      icon: const Icon(Icons.description_sharp),
                      text: 'Detalles'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: BasicInput(
                      inputType: TextInputType.number,
                      needcurrencyFormat: true,
                      controller: priceController,
                      icon: const Icon(Icons.monetization_on_outlined),
                      text: 'Precio'),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    loading
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.only(bottom: 30),
                            child: BasicButton(
                              text: 'Eliminar registro',
                              redButton: true,
                              onclick: () async {
                                setState(() => loading = true);
                                bool success = await Endpoints()
                                    .deleteDebt(id: widget.debtId);
                                setState(() => loading = false);
                                if (success) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ClientDebts(
                                              clientName: widget.clientName,
                                              clientId: widget.clientId)));
                                }
                              },
                            ),
                          ),
                    Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width,
                        color: AppConfig().secundaryColor,
                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  BasicButton(
                                    text: 'Cancelar',
                                    redButton: true,
                                    onclick: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  BasicButton(
                                    text: 'Guardar cambios',
                                    onclick: () {
                                      editDebt();
                                    },
                                  ),
                                ],
                              )),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> debtDelete() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar registro'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Estás seguro de eliminar este registro?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text(
                'Eliminar',
              ),
              onPressed: () async {
                Navigator.pop(context);
                setState(() => loading = true);
                bool success = await Endpoints().deleteDebt(id: widget.debtId);
                setState(() => loading = false);
                if (success) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ClientDebts(
                              clientName: widget.clientName,
                              clientId: widget.clientId)));
                }
              },
            ),
          ],
        );
      },
    );
  }

  editDebt() async {
    setState(() => loading = true);
    var cleanPrice = priceController.text.replaceAll('.', '');
    bool success = await Endpoints().editDebt(
        details: detailController.text,
        total: int.parse(cleanPrice),
        id: widget.debtId);
    setState(() => loading = false);
    if (success) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => ClientDebts(
                  clientName: widget.clientName, clientId: widget.clientId)));
    }
  }
}
