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

  // Future createSupplier(CreateSupplier createSupplier) async {
  //   var token = await prefs.readToken();
  //   var userId = await prefs.getUserId();
  //   var headersList = {
  //     'Accept': '*/*',
  //     'x-api-key': apiKey,
  //     'Authorization': 'Bearer $token'
  //   };

  //   var request =
  //       http.MultipartRequest('POST', Uri.parse('${baseUrl}/api/v1/supply'));
  //   request.headers.addAll(headersList);

  //   request.fields.addAll({
  //     "sup_name": createSupplier.sup_name,
  //     "sup_phone": createSupplier.sup_phone,
  //     "sup_address": createSupplier.sup_address,
  //     "tested_by": userId,
  //     "amount": createSupplier.amount,
  //     "price": createSupplier.price,
  //   });

  //   // File object representing the image
  //   File imageFile = createSupplier.picture;

  //   // Attach the image file to the request
  //   request.files.add(
  //     await http.MultipartFile.fromPath('picture', imageFile.path),
  //   );

  //   try {
  //     final streamedResponse = await request.send();
  //     final response = await http.Response.fromStream(streamedResponse);

  //     if (response.statusCode == 200) {
  //       final responseBody = await response.body;
  //       final data = json.decode(responseBody);

  //       if (data["status"] == "SUCCESS") {
  //         print(responseBody);
  //       } else {
  //         print(responseBody);
  //         throw data["message"];
  //       }
  //     } else {
  //       throw 'Failed to upload image. Status code: ${response.statusCode}';
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw e;
  //   }
  // }

  Future<void> createSupplier(CreateSupplier createSupplier) async {
    var token = await prefs.readToken();
    var userId = await prefs.getUserId();
    var headersList = {
      'Accept': '*/*',
      'x-api-key': apiKey,
      'Authorization': 'Bearer $token'
    };

    // Create a multipart request
    var request =
        http.MultipartRequest('POST', Uri.parse('${baseUrl}/api/v1/supply'));

    // Add headers to the request
    request.headers.addAll(headersList);

    // Add fields to the request
    request.fields.addAll({
      "sup_name": createSupplier.sup_name,
      "sup_phone": createSupplier.sup_phone,
      "sup_address": createSupplier.sup_address,
      "tested_by": userId,
      "amount": createSupplier.amount,
      "price": createSupplier.price,
      "picture": createSupplier.picture.toString(),
    });

    // Get the image file (createSupplier.picture) from File object
    var imageFile = createSupplier.picture;
    print("+++++++++++++++++++++++++++");
    // Attach the image file to the request
    var fileStream = http.ByteStream(imageFile.openRead());
    var length = await imageFile.length();
    var multipartFile = http.MultipartFile(
      'picture',
      fileStream,
      length,
      filename: imageFile.path.split('/').last,
    );

    // Add the image file to the request
    request.files.add(multipartFile);
    print("000000000000000000000000");

    try {
      // Send the request
      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseBody = response.body;
        final data = json.decode(responseBody);

        if (data["status"] == "SUCCESS") {
          print(responseBody);
        } else {
          print(responseBody);
          throw data["message"];
        }
      } else {
        throw 'Failed to create supplier. Status code: ${response.statusCode}';
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
        print(data["message"]);
        print('Failed to update supplier. Status code: ${response.statusCode}');
        throw Exception('Failed to update supplier');
      }
    } catch (e) {
      print('Error updating supplier: $e');
      throw e;
    }
  }

  Future<void> deleteSupplier(String? deleteId) async {
    var token = await prefs.readToken();
    try {
      var headers = {
        'x-api-key': apiKey,
        'Authorization': 'Bearer $token',
      };
      var response = await http.delete(
        Uri.parse('https://fikirapi.onrender.com/api/v1/supply/$deleteId'),
        headers: headers,
      );
      final responseBody = response.body;

      final data = json.decode(responseBody);

      if (response.statusCode == 200) {
        print("Successfully Deleted");
      } else {
        print(data["message"]);
        print('Failed to delete supplier: ${response.reasonPhrase}');
        throw Exception('Failed to delete supplier: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to delete supplier: $e');
    }
  }
}
