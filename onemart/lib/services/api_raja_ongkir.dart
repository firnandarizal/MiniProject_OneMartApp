import 'package:flutter_application_1/env/constants/open_ai.dart';
import 'package:http/http.dart' as http;

class RajaOngkirApi {
  static Future<String> getShippingCost(Map<String, String> data) async {
    String apiUrl = 'https://api.rajaongkir.com/starter/cost';

    Map<String, String> headers = {
      'content-type': 'application/x-www-form-urlencoded',
      'key': rajaOngkirApiKey,
    };

    try {
      var response = await http.post(Uri.parse(apiUrl), headers: headers, body: data);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        throw Exception("HTTP Request failed with status: ${response.statusCode}\nResponse body: ${response.body}");
      }
    } catch (error) {
      throw Exception("Error during HTTP request: $error");
    }
  }
}