import 'dart:convert';

import 'package:fikir_milk/globals.dart';
import 'package:fikir_milk/homeScreen/data/models/createSupplier.dart';
import 'package:fikir_milk/homeScreen/data/models/supplierModel.dart';
import 'package:fikir_milk/homeScreen/data/models/updateSupplier.dart';

import 'package:fikir_milk/sp_services.dart';
import 'package:http/http.dart' as http;

class HomeDataSource {
  final prefs = PrefService();
  Future<List<Suppliers>> getSupplierList() async {
    var token = await prefs.readToken();

    var headersList = {
      'Accept': '*/',
      'x-api-key': apiKey,
      'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse('${baseUrl}/api/v1/supply');

    var response = await http.get(uri, headers: headersList);
    final responseBody = response.body;

    final data = json.decode(responseBody);

    try {
      if (data["status"] == "SUCCESS") {
        List suppliers = data["data"]["supply"];
        List<Suppliers> allSuppliers =
            suppliers.map((supply) => Suppliers.fromJson(supply)).toList();
        return allSuppliers;
      } else {
        print(responseBody);
        throw data["message"];
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future createSupplier(CreateSupplier createSupplier) async {
    var token = await prefs.readToken();
    var userId = await prefs.getUserId();
    var headersList = {
      'Accept': '*/*',
      'x-api-key': apiKey,
      'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse('${baseUrl}/api/v1/supply');

    Map<String, dynamic> body;

    body = {
      "sup_name": createSupplier.sup_name,
      "sup_phone": createSupplier.sup_phone,
      "sup_address": createSupplier.sup_address,
      "tested_by": userId,
      "amount": createSupplier.amount,
      "price": createSupplier.price,
      "picture": createSupplier.picture,
    };
    // body = {
    //   "sup_name": "Abebe Kebede",
    //   "sup_phone": "0923938609",
    //   "sup_address": "Sarris",
    //   "tested_by": userId,
    //   "amount": "40",
    //   "price": "2000",
    //   "picture": "/C:/Users/leint/Music/game_math_arithmetic.png",
    // };

    var response = await http.post(uri, headers: headersList, body: body);
    final responseBody = response.body;

    final data = json.decode(responseBody);

    try {
      if (data["status"] == "SUCCESS") {
        print(responseBody);
      } else {
        print(responseBody);
        throw data["message"];
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateSupplier(UpdateSupplier updateSupplier) async {
    try {
      var token = await prefs.readToken();
      String supplierId = await prefs.getSupplierId();

      var headersList = {
        'Accept': '*/*',
        'x-api-key': apiKey,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      var uri = Uri.parse('$baseUrl/api/v1/supply/$supplierId');

      var body = {
        'sup_phone': updateSupplier.sup_phone,
        'tests': {
          'cob': updateSupplier.tests.cob,
          'organo_leptic': updateSupplier.tests.organo_leptic,
          'gerber': updateSupplier.tests.gerber,
        },
      };

      var response =
          await http.patch(uri, headers: headersList, body: json.encode(body));

      final responseBody = response.body;

      final data = json.decode(responseBody);

      if (data["status"] == "SUCCESS") {
        print("Supplier Updated Successfully!");
        // Handle successful response if needed
      } else {
        print('Failed to update supplier. Status code: ${response.statusCode}');
        throw Exception('Failed to update supplier');
      }
    } catch (e) {
      print('Error updating supplier: $e');
      throw e;
    }
  }

  Future deleteSupplier(String? deleteId) async {
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NTFjMTVkZjkyMjRjZTExYmE0NjY4MyIsImlhdCI6MTcwMTI2ODgzMCwiZXhwIjoxNzAyNTY0ODMwfQ.rJScaZCFqr4zATKNUoV0vRvUdRO7_MEu_FYk4DCnds0'
    };
    var request = http.Request('DELETE',
        Uri.parse('https://fikirapi.onrender.com/api/v1/supply/${deleteId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
