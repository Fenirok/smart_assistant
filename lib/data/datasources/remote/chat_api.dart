import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/api_constants.dart';

class ChatRemoteDataSource {
  Future<String> sendMessage(String userMessage) async {
    final response = await http.post(
      Uri.parse(ApiConstants.chat),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "message": userMessage,
      }),
    );
    if (response.statusCode == 200) {

      final decoded = jsonDecode(response.body);

      return decoded['reply'];
    } else {
      throw Exception("Failed to send message");
    }
  }
}