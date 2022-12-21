import 'package:flutter/material.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/models/createDebtModel.dart';
import 'package:pymes_app/models/debtsListModel.dart';
import 'package:pymes_app/pages/clientDebts.dart';
import 'package:pymes_app/widgets/basicInput.dart';
import 'package:pymes_app/widgets/newDebtCard.dart';

import '../appConfig.dart';
import '../widgets/appBar.dart';
import '../widgets/basicButton.dart';

class CreateDebt extends StatefulWidget {
  final String clientId;
  final String clienName;
  const CreateDebt(
      {super.key, required this.clientId, required this.clienName});

  @override
  State<CreateDebt> createState() => _CreateDebtState();
}

class _CreateDebtState extends State<CreateDebt> {
  var productController = TextEditingController();
  var priceController = TextEditingController();
  List<CreateDebtModel> debtList = [];
  int totalPrice = 0;
  bool loading = false;

  addNewProduct() {
    if (dataValidation()) {
      CreateDebtModel model = CreateDebtModel(
          createdAt: DateTime.now(),
          productName: productController.text,
          productPrice: priceController.text);
      debtList.add(model);
      var clearNum = model.productPrice.replaceAll('.', '');
      totalPrice = totalPrice + int.parse(clearNum);
      setState(() {});
      productController.clear();
      priceController.clear();
    }
  }

  dataValidation() {
    if (productController.text.isEmpty || priceController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  cardRemove(index) {
    var clearNum = debtList[index].productPrice.replaceAll('.', '');
    totalPrice = totalPrice - int.parse(clearNum);
    debtList.removeAt(index);
    setState(() {});
  }

  debtRegister() async {
    if (debtList.isNotEmpty) {
      setState(() => loading = true);
      String m = '';
      if (debtList.length > 1) {
        for (var i = 0; i < debtList.length; i++) {
          String n = debtList[i].productName;
          m = '$n, $m';
        }
      } else if (debtList.length == 1) {
        m = debtList[0].productName;
      }
      DebtsListModel newData = await Endpoints().debtRegister(
          details: m, total: totalPrice, clientId: widget.clientId);
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
          child: const MyAppBar(tittle: 'Alfredo')),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                color: AppConfig().secundaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Nueva Deuda'),
                    Text(AppConfig().dateFormat(date: DateTime.now()))
                  ],
                ),
              ),
              Container(
                // margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: BasicInput(
                          controller: productController,
                          icon: const Icon(Icons.shopping_bag_outlined),
                          text: 'Producto'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: BasicInput(
                        inputType: TextInputType.number,
                        controller: priceController,
                        icon: const Icon(Icons.monetization_on),
                        text: 'Precio',
                        needcurrencyFormat: true,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        addNewProduct();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: AppConfig().buttonColor,
                            borderRadius: BorderRadius.circular(20)),
                        width: MediaQuery.of(context).size.width * 0.15,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: const Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: WidgetsBinding.instance.window.viewInsets.bottom > 0.0
                    ? MediaQuery.of(context).size.height * 0.37
                    : MediaQuery.of(context).size.height * 0.62,
                child: ListView(
                  children: [
                    for (var i = 0; i < debtList.length; i++)
                      NewDebtCard(
                        productName: debtList[i].productName,
                        productPrice: debtList[i].productPrice,
                        funci: () {
                          cardRemove(i);
                        },
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
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width,
                  color: AppConfig().secundaryColor,
                  child: loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 50,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(20)),
                              child:
                                  Text(AppConfig().currencyFormat(totalPrice)),
                            ),
                            BasicButton(
                              text: 'Registrar deuda total',
                              onclick: () {
                                debtRegister();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => CreateDebt()));
                              },
                            ),
                          ],
                        )))
        ],
      ),
    );
  }
}
