import 'package:flutter/material.dart';
import 'package:smart_assistant/data/models/message_bubble_model.dart';
import '../data/datasources/repositories/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository repository;

  ChatViewModel(this.repository) {
    loadMessages(); // load saved messages
  }

  List<MessageBubble> messages = [];
  bool isTyping = false;

  // LOAD FROM HIVE
  void loadMessages() {
    final data = repository.getLocalMessages();

    messages = data
        .map((e) => MessageBubble.fromMap(e))
        .toList();

    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMsg = MessageBubble(
      text: text,
      isUser: true,
      time: DateTime.now(),
    );

    messages.add(userMsg);

    // SAVE USER MESSAGE
    repository.saveMessage(userMsg.toMap());

    notifyListeners();

    isTyping = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 400));

      final reply = await repository.getReply(text);

      final botMsg = MessageBubble(
        text: reply,
        isUser: false,
        time: DateTime.now(),
      );

      messages.add(botMsg);

      // SAVE BOT MESSAGE
      repository.saveMessage(botMsg.toMap());

    } catch (e) {
      messages.add(
        MessageBubble(
          text: "Something went wrong",
          isUser: false,
          time: DateTime.now(),
        ),
      );
    }

    isTyping = false;
    notifyListeners();
  }
}