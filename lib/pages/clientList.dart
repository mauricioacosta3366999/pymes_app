import 'package:flutter/material.dart';
import 'package:pymes_app/appConfig.dart';
import 'package:pymes_app/pages/createClient.dart';
import 'package:pymes_app/widgets/appBar.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/basicInput.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../widgets/clientCard.dart';

class ClientListPage extends StatefulWidget {
  const ClientListPage({super.key});

  @override
  State<ClientListPage> createState() => _ClientListPageState();
}

class _ClientListPageState extends State<ClientListPage> {
  var searcherController = TextEditingController();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    getClients();
  }

  getClients() async {
    final data = await supabase.from('Clients').select('name');
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
          child: const MyAppBar(tittle: 'Empresa S.A.')),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                color: AppConfig().secundaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text('Monto a cobrar: 150.000.000 Gs'),
                    Text('Clientes: 109')
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
                height: MediaQuery.of(context).size.height * 0.65,
                child: ListView(
                  children: [
                    for (var i = 0; i < 10; i++)
                      const ClientCard(
                        clientName: 'Nombre Prueba',
                        clientDebt: '1.000.000',
                      )
                  ],
                ),
              ),
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
                    text: 'Agregar cliente',
                    onclick: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateClient()));
                    },
                  )))
        ],
      ),
    );
  }
}
