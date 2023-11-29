import 'dart:convert';

import 'package:fikir_milk/globals.dart';
import 'package:fikir_milk/homeScreen/data/models/supplierModel.dart';

import 'package:fikir_milk/sp_services.dart';
import 'package:http/http.dart' as http;

class HomeDataSource {
  final prefs = PrefService();
  Future<Suppliers> getSupplierList() async {
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
        Map<String, dynamic> suppliers = data["data"]["supply"];
        print(" I'm the one");

        Suppliers suppliersList = Suppliers(
            id: suppliers["id"],
            sup_name: suppliers["sup_name"],
            sup_phone: suppliers["sup_phone"],
            sup_address: suppliers["sup_address"],
            tested_by: suppliers["tested_by"]);

        return suppliersList;
      } else {
        print(responseBody);
        throw data["message"];
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
