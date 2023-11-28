import 'dart:convert';

import 'package:fikir_milk/globals.dart';
import 'package:fikir_milk/sp_services.dart';
import 'package:http/http.dart' as http;
import 'package:fikir_milk/auth/signin/data/loginModel.dart';

class LoginDataSource {
  final pref = PrefService();

  Future<bool> loginUser(Login login) async {
    var headersList = {
      'Accept': '*/*',
      'x-api-key': apiKey,
      'Content-Type': 'application/json'
    };

    var uri = Uri.parse('${baseUrl}/api/v1/users/login');

    var body = {
      "email_or_phone": login.email_or_phone,
      "password": login.password
    };
    var response =
        await http.post(uri, headers: headersList, body: json.encode(body));
    final responseBody = response.body;

    final data = json.decode(responseBody);

    try {
      if (data["status"] == "SUCCESS") {
        print(responseBody);
        await pref.storeToken(data["token"]);
        await pref.setUserId(data["data"]["user"]["id"]);
        bool isActive = data["data"]["user"]["status"] == "Active";
        return isActive;
      } else {
        print(responseBody);
        throw data["message"];
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future forgotPassword(String email) async {
    var headersList = {
      'Accept': '*/*',
      'x-api-key': apiKey,
      'Content-Type': 'application/json'
    };

    var uri = Uri.parse("${baseUrl}/api/v1/users/forgotpassword");

    var body = {"email": email};
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

  Future resetPassword(String id) async {
    var uri =
        Uri.parse("${baseUrl}/api/v1/users/65280064855188d85758bfff/reset");

    var response = await http.patch(uri);
    var responseBody = response.body;

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
