import 'package:flutter/material.dart';
import 'package:pymes_app/models/clientListModel.dart';
import 'package:pymes_app/models/debtsListModel.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Endpoints {
  final storage = const FlutterSecureStorage();
  final supabaseClient = SupabaseClient(
      'https://zteskqktpwjklhjfapxz.supabase.co',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inp0ZXNrcWt0cHdqa2xoamZhcHh6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjYzOTkxOTAsImV4cCI6MTk4MTk3NTE5MH0.R59D0W-UYkqOkV-s1PTbcGsuuuVUYjfaS5KPsO0_tSg');

  createUser({required String email, required String pass}) async {
    try {
      await supabaseClient.auth.signUp(email: email, password: pass);
      return true;
    } catch (e) {
      return false;
    }
  }

  login({required String email, required String pass}) async {
    try {
      var response = await supabaseClient.auth
          .signInWithPassword(email: email, password: pass);
      await storage.write(key: 'token', value: response.session!.accessToken);
      await storage.write(key: 'pymeId', value: response.user!.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  getClientList() async {
    try {
      var id = await storage.read(key: 'pymeId');
      var response =
          await supabaseClient.from('Clients').select('*').eq('pymeId', id);
      var clientList = (response as List<dynamic>)
          .map((e) => ClientListModel.fromJson(e))
          .toList();
      print(clientList);
      return clientList;
    } catch (e) {
      print(e);
      return [];
    }
  }

  getClientDebtsList({required String clientId}) async {
    try {
      var response = await supabaseClient
          .from('Debts')
          .select('*')
          .eq('clientid', clientId);
      var debtslist = (response as List<dynamic>)
          .map((e) => DebtsListModel.fromJson(e))
          .toList();
      return debtslist;
    } catch (e) {
      return [];
    }
  }

  createClient({required String name, required String phone}) async {
    try {
      var id = await storage.read(key: 'pymeId');
      var response = await supabaseClient
          .from('Clients')
          .insert({'name': name, 'phone': phone, 'pymeId': id, 'total': 0});
      print(response);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  debtRegister(
      {required String details,
      required int total,
      required String clientId}) async {
    try {
      var response = await supabaseClient.from('Debts').insert(
          {'details': details, 'total': total, 'clientid': clientId}).select();
      DebtsListModel model = DebtsListModel.fromJson(response[0]);
      print(model);
      return model;
    } catch (e) {
      print(e);
    }
  }
}
