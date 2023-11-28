import 'dart:convert';

import 'package:fikir_milk/auth/signup/data/signupModel.dart';
import 'package:fikir_milk/globals.dart';
import 'package:fikir_milk/sp_services.dart';
import 'package:http/http.dart' as http;

class SignUpDataSource {
  final prefs = PrefService();
  Future signUp(SignUp signUp) async {
    var token = await prefs.readToken();
    var headersList = {
      'Accept': '*/*',
      'x-api-key': apiKey,
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse('${baseUrl}/api/v1/users');

    Map<String, dynamic> body;

    body = {
      "full_name": signUp.full_name,
      "phone_number": signUp.phone_number,
      "role": signUp.role,
      "email": signUp.email
    };
    var response =
        await http.post(uri, headers: headersList, body: json.encode(body));
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
}
