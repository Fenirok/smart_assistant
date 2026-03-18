import 'package:flutter/material.dart';
import 'package:smart_assistant/data/models/message_bubble_model.dart';
import '../data/datasources/repositories/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository repository;

  ChatViewModel(this.repository);

  List<MessageBubble> messages = [];
  bool isTyping = false;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    messages.add(
      MessageBubble(
        text: text,
        isUser: true,
        time: DateTime.now(),
      ),
    );
    notifyListeners();

    isTyping = true;
    notifyListeners();

    try {
      await Future.delayed(Duration(milliseconds: 400));

      final reply = await repository.getReply(text);

      messages.add(
        MessageBubble(
          text: reply,
          isUser: false,
          time: DateTime.now(),
        ),
      );
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