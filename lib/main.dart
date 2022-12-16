import 'package:flutter/material.dart';
import 'package:pymes_app/pages/clientList.dart';
import 'package:pymes_app/pages/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  const accesToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOiJhdXRoZW50aWNhdGVkIiwiZXhwIjoxNjcwNDQyNTExLCJzdWIiOiIxMTQ3YjRkYS00YTM1LTQ5YjYtYTFjOS1mOWJhZjMzMzM3NTIiLCJlbWFpbCI6ImFjb3N0YW1hdXJpY2lvMzM2Njk5QGdtYWlsLmNvbSIsInBob25lIjoiIiwiYXBwX21ldGFkYXRhIjp7InByb3ZpZGVyIjoiZW1haWwiLCJwcm92aWRlcnMiOlsiZW1haWwiXX0sInVzZXJfbWV0YWRhdGEiOnt9LCJyb2xlIjoiYXV0aGVudGljYXRlZCIsImFhbCI6ImFhbDEiLCJhbXIiOlt7Im1ldGhvZCI6Im90cCIsInRpbWVzdGFtcCI6MTY3MDQzODkxMX1dLCJzZXNzaW9uX2lkIjoiZjY3M2U3NDQtNzJlYy00MTI3LTgwMTAtMDQzM2M3YjU0MGE4In0.0xYC68v9qXd-Oqgp5LPGMLnrVfduzwdYBmG-DdDMdHI';
  const supabaseKey = String.fromEnvironment(
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp0ZXNrcWt0cHdqa2xoamZhcHh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjYzOTkxOTAsImV4cCI6MTk4MTk3NTE5MH0.R59D0W-UYkqOkV-s1PTbcGsuuuVUYjfaS5KPsO0_tSg');
  await Supabase.initialize(
      url: 'https://zteskqktpwjklhjfapxz.supabase.co',
      anonKey: supabaseKey,
      headers: {
        'Authorization': 'Bearer $accesToken',
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
