import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../constants/api_constants.dart';
import '../../models/chat_model.dart';

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

      final List list = decoded;

      final items =
      list.map((e) => ChatItem.fromJson(e)).toList();

      final matched = items.firstWhere(
            (item) =>
        item.message.toLowerCase().trim() ==
            userMessage.toLowerCase().trim(),
        orElse: () => ChatItem(
          id: "0",
          message: "",
          reply: "Sorry, I don't understand that yet.",
        ),
      );

      return matched.reply;
    } else {
      throw Exception("Failed to send message");
    }
  }
}