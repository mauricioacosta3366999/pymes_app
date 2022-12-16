import 'package:flutter/material.dart';
import 'package:pymes_app/pages/clientList.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/basicInput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var userController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            Image.asset(
              "assets/images/test.jpeg",
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Bienvenido',
                  style: TextStyle(fontSize: 27),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.15,
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: BasicInput(
                  controller: userController,
                  icon: const Icon(Icons.person),
                  text: 'Usuario'),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: BasicInput(
                  controller: userController,
                  icon: const Icon(Icons.key),
                  text: 'Contraseña'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            BasicButton(
                onclick: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClientListPage()));
                },
                text: 'Ingresar'),
          ],
        ),
      ),
    );
  }
}
