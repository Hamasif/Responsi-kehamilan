import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://103.196.155.42/api';
  String? authToken; // Menyimpan token otentikasi

  // Fungsi login
  Future<String> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Login response body: ${response.body}'); // Debugging

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true) {
        if (responseData['data'] != null &&
            responseData['data']['token'] != null) {
          authToken = responseData['data']['token'];
          return authToken!;
        } else {
          throw Exception('Login successful but no token received');
        }
      } else {
        throw Exception(responseData['data'] ?? 'Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // Fungsi register
  Future<void> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/registrasi'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nama': name, 'email': email, 'password': password}),
      );

      print('Register response body: ${response.body}'); // Debugging

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == true) {
        print('Registration successful');
      } else {
        throw Exception(responseData['data'] ?? 'Failed to register');
      }
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

 Future<List<Map<String, dynamic>>> getPregnancyRecords() async {
  final response = await http.get(Uri.parse('$baseUrl/pregnancy'));

  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((record) => record as Map<String, dynamic>).toList();
  } else {
    throw Exception('Failed to load records: ${response.statusCode}');
  }
}


  Future<Map<String, dynamic>> addPregnancyRecord(Map<String, dynamic> record) async {
    final response = await http.post(
      Uri.parse('$baseUrl/pregnancy'),
      body: jsonEncode(record),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add record');
    }
  }

  Future<void> updatePregnancyRecord(int id, Map<String, dynamic> record) async {
    final response = await http.put(
      Uri.parse('$baseUrl/pregnancy/$id'),
      body: jsonEncode(record),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update record');
    }
  }

  Future<void> deletePregnancyRecord(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/pregnancy/$id'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete record');
    }
  }
}
