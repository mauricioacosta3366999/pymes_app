import 'package:flutter/material.dart';
import 'package:pymes_app/appConfig.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/models/clientListModel.dart';
import 'package:pymes_app/pages/createClient.dart';
import 'package:pymes_app/widgets/appBar.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/basicInput.dart';

import '../widgets/clientCard.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  var searcherController = TextEditingController();
  List<ClientListModel> clientList = [];
  bool loading = false;
  int allDeude = 0;

  @override
  void initState() {
    super.initState();
    getClients();
  }

  getClients() async {
    setState(() => loading = true);
    clientList = await Endpoints().getClientList();
    setState(() => loading = false);
    getTotalDeude();
  }

  getTotalDeude() {
    for (var i = 0; i < clientList.length; i++) {
      allDeude = allDeude + clientList[i].total!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: const MyAppBar(tittle: 'Empresa S.A.')),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: AppConfig().secundaryColor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text('Monto a cobrar: '),
                            Text(AppConfig().currencyFormat(allDeude))
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: BasicInput(
                            controller: searcherController,
                            icon: const Icon(Icons.search),
                            text: 'Buscar cliente'),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ListView(
                          children: [
                            for (var i = 0; i < clientList.length; i++)
                              ClientCard(
                                clientName: clientList[i].name!,
                                clientDebt: AppConfig()
                                    .currencyFormat(clientList[i].total!),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.07,
                        width: MediaQuery.of(context).size.width,
                        color: AppConfig().secundaryColor,
                        child: BasicButton(
                          text: 'Agregar cliente',
                          onclick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateClient()));
                          },
                        )))
              ],
            ),
    );
  }
}
