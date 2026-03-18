import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/api_constants.dart';


class ChatHistoryRemoteDataSource {
  Future<List<Map<String, dynamic>>> fetchHistory() async {
    final response = await http.get(
      Uri.parse(ApiConstants.history),
    );

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(decoded['data']);
    } else {
      throw Exception("Failed to load history");
    }
  }
}