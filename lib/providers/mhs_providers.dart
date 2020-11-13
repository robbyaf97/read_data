import 'package:read_data/models/mhs_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MhsProvider extends ChangeNotifier {
  List<MhsModel> _data = [];
  List<MhsModel> get dataMhs => _data;

  Future<List<MhsModel>> getMhs() async {
    final url = 'https://flutterrobby.000webhostapp.com/readDatajson.php';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result.map<MhsModel>((json) => MhsModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  //ADD DATA
  Future<bool> storeMhs(String nim, String nama, String kelas, String kdmatkul, String email) async {
    final url = 'https://flutterrobby.000webhostapp.com/inputDatajson.php';
    final response = await http.post(url, body: {
      'mhs_nim': name,
      'mhs_nama': nama,
      'mhs_kelas': kelas,
      'mhs_kdmatkul': kdmatkul,
      'mhs_email': email
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<MhsModel> findMhs(String nim) async {
    return _data.firstWhere((i) => i.nim == nim);
  }

  Future<bool> updateMhs(nim, nama, kelas, kdmatkul, email) async {
    final url = 'https://flutterrobby.000webhostapp.com/editDatajson.php';
    final response = await http.post(url, body: {
      'mhs_nim': nim,
      'mhs_nama': nama,
      'mhs_kelas': kelas,
      'mhs_kdmatkul': kdmatkul,
      'mhs_email': email
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> deleteMhs(String nim) async {
    final url = 'https://flutterrobby.000webhostapp.com/deleteDatajson.php';
    await http.get(url + '?nim=$nim');
  }
}
