import 'package:flutter/material.dart';
import 'package:pymes_app/widgets/appBar.dart';
import 'package:pymes_app/widgets/basicInput.dart';
import 'package:pymes_app/widgets/tittle.dart';

import '../appConfig.dart';
import '../widgets/basicButton.dart';

class CreateClient extends StatefulWidget {
  const CreateClient({super.key});

  @override
  State<CreateClient> createState() => _CreateClientState();
}

class _CreateClientState extends State<CreateClient> {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
            child: const MyAppBar(tittle: 'Empresa S.A.')),
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 100),
                const PrincipalTitle(text: 'Nombre del cliente'),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: BasicInput(
                      controller: nameController,
                      icon: const Icon(Icons.person),
                      text: 'Nombre'),
                ),
                const PrincipalTitle(text: 'Número de telefono del cliente'),
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: BasicInput(
                    controller: phoneController,
                    icon: const Icon(Icons.phone),
                    text: 'telefono',
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
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BasicButton(
                          text: 'Crear cliente',
                          onclick: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateClient()));
                          },
                        ),
                        BasicButton(
                          text: 'Cancelar',
                          redButton: true,
                          onclick: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    )))
          ],
        ));
  }
}
