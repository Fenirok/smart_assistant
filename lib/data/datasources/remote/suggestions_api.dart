import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/api_constants.dart';

class SuggestionRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchAllSuggestions() async {
    final response = await http.get(
      Uri.parse(ApiConstants.suggestions),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(decoded['data']);
    } else {
      throw Exception("Failed to fetch suggestions");
    }
  }
}