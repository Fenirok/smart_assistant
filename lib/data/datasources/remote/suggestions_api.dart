import 'dart:convert';
import 'package:http/http.dart' as http;

class SuggestionRemoteDataSource {
  final String baseUrl;

  SuggestionRemoteDataSource(this.baseUrl);

  Future<List<Map<String, dynamic>>> fetchAllSuggestions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/suggestions'),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(decoded['data']);
    } else {
      throw Exception("Failed to fetch suggestions");
    }
  }
}