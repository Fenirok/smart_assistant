import 'package:hive/hive.dart';

class ChatLocalDataSource {
  final Box box = Hive.box('chatBox');

  // Save message
  void saveMessage(Map<String, dynamic> message) {
    final List messages = box.get('messages', defaultValue: []);
    messages.add(message);
    box.put('messages', messages);
  }

  // Get all messages
  List<Map<String, dynamic>> getMessages() {
    final List data = box.get('messages', defaultValue: []);

    return data.map((e) {
      return Map<String, dynamic>.from(e); // 🔥 FIX
    }).toList();
  }

  // Clear chat
  void clearChat() {
    box.put('messages', []);
  }
}