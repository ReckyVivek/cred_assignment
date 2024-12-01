import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService._privateConstructor();
  static final ApiService _instance = ApiService._privateConstructor();
  factory ApiService() => _instance;

  final String apiUrl = 'https://api.mocklets.com/p6764/test_mint/';
  Map<String, dynamic>? _cachedData;

  Future<Map<String, dynamic>> fetchData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      _cachedData = json.decode(response.body);
      return _cachedData!;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
