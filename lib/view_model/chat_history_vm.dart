import 'package:flutter/material.dart';
import 'package:smart_assistant/data/models/conversation_model.dart';
import '../data/datasources/repositories/chat_history_repository.dart';
import '../data/models/chat_history_model.dart';


class ChatHistoryViewModel extends ChangeNotifier {
  final ChatHistoryRepository repository;

  List<Conversations> conversations = [];
  bool isLoading = false;

  ChatHistoryViewModel(this.repository);

  Future<void> loadHistory() async {
    isLoading = true;
    notifyListeners();

    try {
      conversations = await repository.getHistory();
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }
}