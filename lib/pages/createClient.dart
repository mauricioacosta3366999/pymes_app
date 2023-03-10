import 'package:flutter/material.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/pages/clientList.dart';
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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
            child: MyAppBar(tittle: AppConfig().pymeName)),
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
                    inputType: TextInputType.number,
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
                    color: AppConfig().secundaryColor,
                    child: loading
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BasicButton(
                                text: 'Cancelar',
                                redButton: true,
                                onclick: () {
                                  Navigator.pop(context);
                                },
                              ),
                              BasicButton(
                                text: 'Crear cliente',
                                onclick: () {
                                  cilentCreate();
                                },
                              ),
                            ],
                          )))
          ],
        ));
  }

  cilentCreate() async {
    if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          AppConfig().showSnack('Agrega el nombre de tu cliente', 3));
    } else {
      setState(() => loading = true);
      bool success = await Endpoints()
          .createClient(name: nameController.text, phone: phoneController.text);
      setState(() => loading = false);
      if (success) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const ClientListPage()),
            (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(AppConfig().showSnack('Algo salió mal', 3));
      }
    }
  }
}
