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
  List<ClientListModel> searcherClientList = [];
  bool loading = false;
  bool userSearchList = false;

  @override
  void initState() {
    super.initState();
    getClients();
  }

  getClients() async {
    setState(() => loading = true);
    clientList = await Endpoints().getClientList();
    searcherClientList = clientList;
    setState(() => loading = false);
  }

  searcher() async {
    if (searcherController.text.isEmpty) {
      setState(() => userSearchList = false);
    } else {
      searcherClientList = [];
      setState(() => userSearchList = true);
      for (var i = 0; i < clientList.length; i++) {
        if (clientList[i].name!.contains(searcherController.text)) {
          searcherClientList.add(clientList[i]);
        }
      }
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
          child: MyAppBar(tittle: AppConfig().pymeName)),
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
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.1,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: BasicInput(
                            onChange: () {
                              searcher();
                            },
                            controller: searcherController,
                            icon: const Icon(Icons.search),
                            text: 'Buscar cliente'),
                      ),
                      userSearchList
                          ? SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: ListView(
                                children: [
                                  for (var i = 0;
                                      i < searcherClientList.length;
                                      i++)
                                    ClientCard(
                                      clientName: searcherClientList[i].name!,
                                      clientId: searcherClientList[i].id!,
                                    )
                                ],
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: ListView(
                                children: [
                                  for (var i = 0; i < clientList.length; i++)
                                    ClientCard(
                                      clientName: clientList[i].name!,
                                      clientId: clientList[i].id!,
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
                        height: MediaQuery.of(context).size.height * 0.1,
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
