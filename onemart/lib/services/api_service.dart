// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Get data
  static Future<List<Map<String, dynamic>>> fetchData() async {
    const String getUrlData = 'http://192.168.43.75/api/api.php';
    final response = await http.get(Uri.parse(getUrlData));

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
  static Future<void> addItem(Map<String, dynamic> newItem) async {
    const String addUrlData = 'http://192.168.43.75/api/api.php';

    print('Add Item: $newItem');

    try {
      final http.Response response = await http.post(
        Uri.parse(addUrlData),
        body: newItem,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      print('Add response: ${response.body}');

      if (response.statusCode == 200) {
        print('Item berhasil ditambahkan');
      } else {
        print('HTTP Error: ${response.statusCode}');
        print('Response Body: ${response.body}');
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw error; // Rethrow the error to propagate it to the caller
    }
  }

  // Update Data
  static Future<void> updateItem(
      String itemId, Map<String, dynamic> updatedItem) async {
    final String updateUrlData =
        'http://192.168.43.75/api/api.php/data?id=$itemId';

    try {
      final http.Response response = await http.post(
        Uri.parse(updateUrlData),
        body: Uri(queryParameters: updatedItem).query,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 200) {
        print('Item berhasil diupdate');
      } else {
        print('error code');
      }
    } catch (error) {
      print('err: $error');
    }
  }

  // Delete Data
  static Future<void> deleteData(String itemId) async {
    final url = 'http://192.168.43.75/api/api.php/data?id=$itemId';

    try {
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Data deleted ');
      } else {
        print('error code');
      }
    } catch (error) {
      print('err: $error');
    }
  }
}
