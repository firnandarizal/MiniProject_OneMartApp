import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiServiceUsers {
  // Get data
  static Future<List<Map<String, dynamic>>> fetchDataUsers() async {
    const String getUrlDataUsers = 'http://192.168.43.75/api/api_users.php';
    final response = await http.get(Uri.parse(getUrlDataUsers));

    if (response.statusCode == 200) {
      final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
        json.decode(response.body)['data'],
      );
      return data;
    } else {
      throw Exception('Gagal fetch data');
    }
  }

  // Add Data
  static Future<void> addItemUsers(Map<String, dynamic> newItem) async {
    const String addUrlDataUsers = 'http://192.168.43.75/api/api_users.php';

    try {
      final http.Response response = await http.post(
        Uri.parse(addUrlDataUsers),
        body: newItem,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('Add response: ${response.body}');

      if (response.statusCode == 200) {
        print('Item berhasil ditambahkan');
      } else {
        print('error code');
      }
    } catch (error) {
      print('error: $error');
    }
  }
}
