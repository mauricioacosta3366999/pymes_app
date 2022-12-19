import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pymes_app/pages/clientList.dart';
import 'package:pymes_app/pages/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    userCheck();
    super.initState();
  }

  userCheck() async {
    var storage = const FlutterSecureStorage();
    var id = await storage.read(key: 'pymeId');
    if (id == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ClientListPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffD7F5F3),
      body: Center(
        child: Image.asset(
          "assets/images/loader.gif",
          height: MediaQuery.of(context).size.height * 0.35,
        ),
      ),
    );
  }
}
