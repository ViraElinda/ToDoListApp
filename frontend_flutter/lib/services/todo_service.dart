import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class TodoService {
  final String baseUrl = 'http://192.168.0.107:8000/api';

  Future<Map<String, String>> _getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
  }

  Future<List<dynamic>> getTodos() async {
    final headers = await _getHeaders();
    final response = await http.get(Uri.parse('$baseUrl/todos'), headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memuat todo');
    }
  }

  Future<void> createTodo(String title) async {
    final headers = await _getHeaders();
    await http.post(Uri.parse('$baseUrl/todos'), headers: headers, body: {'title': title});
  }

  Future<void> deleteTodo(int id) async {
    final headers = await _getHeaders();
    await http.delete(Uri.parse('$baseUrl/todos/$id'), headers: headers);
  }

  Future<void> updateTodo(int id, String title) async {
    final headers = await _getHeaders();
    await http.put(Uri.parse('$baseUrl/todos/$id'), headers: headers, body: {'title': title});
  }
}
