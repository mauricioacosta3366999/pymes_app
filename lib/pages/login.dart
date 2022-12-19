import 'package:flutter/material.dart';
import 'package:pymes_app/appConfig.dart';
import 'package:pymes_app/endpoints.dart';
import 'package:pymes_app/pages/clientList.dart';
import 'package:pymes_app/widgets/basicButton.dart';
import 'package:pymes_app/widgets/basicInput.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var userController = TextEditingController();
  var passController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
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
                    controller: passController,
                    icon: const Icon(Icons.key),
                    text: 'Contraseña'),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              loading
                  ? const CircularProgressIndicator()
                  : BasicButton(
                      onclick: () {
                        validations();
                      },
                      text: 'Ingresar'),
            ],
          ),
        ),
      ),
    );
  }

  validations() async {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userController.text);
    if (userController.text.isEmpty || passController.text.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(AppConfig().showSnack('Completa todos los campos', 3));
    } else if (!emailValid) {
      ScaffoldMessenger.of(context)
          .showSnackBar(AppConfig().showSnack('Completa todos los campos', 3));
    } else {
      bool succes = await Endpoints()
          .login(email: userController.text, pass: passController.text);

      if (succes) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ClientListPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            AppConfig().showSnack('Credenciales incorrectos.', 3));
      }
    }
  }
}

// sólo hazo, algún día los remanentes oscuron de lo que algún día
//  fueron estrellas que colapsaron bajo su propia gravedad hasta fracturar
//  el espacio reinaran en un universo oscuro frio y vacío donde sólo queden colisiones entre agujeros negros
