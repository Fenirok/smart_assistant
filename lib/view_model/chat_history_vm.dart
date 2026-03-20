import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:smart_assistant/data/models/conversation_model.dart';
import '../data/datasources/repositories/chat_history_repository.dart';
import 'dart:async';

class ChatHistoryViewModel extends ChangeNotifier {
  final ChatHistoryRepository repository;

  List<Conversations> conversations = [];
  bool isLoading = false;
  bool _isFetching = false;

  ChatHistoryViewModel(this.repository) {
    listenToConnectivity();
  }

  StreamSubscription? _subscription;

  void listenToConnectivity() {
    _subscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none && !_isFetching) {
        loadHistory();
      }
    });
  }
  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> loadHistory() async {
    if (_isFetching) return;

    _isFetching = true;
    isLoading = true;
    notifyListeners();

    try {
      final connectivity = await Connectivity().checkConnectivity();

      if (connectivity != ConnectivityResult.none) {
        // ONLINE
        final apiData = await repository.getHistory();

        if (apiData.isNotEmpty) {
          conversations = apiData;
        } else {

          final localData = repository.getLocalMessages();
          conversations = _convertHiveToConversations(localData);
        }
      } else {
        // OFFLINE
        final localData = repository.getLocalMessages();
        conversations = _convertHiveToConversations(localData);
      }

    } catch (e) {
      print("ERROR: $e");

      final localData = repository.getLocalMessages();
      conversations = _convertHiveToConversations(localData);
    }

    isLoading = false;
    _isFetching = false;
    notifyListeners();
  }

  List<Conversations> _convertHiveToConversations(List data) {
    List<Conversations> result = [];

    for (int i = 0; i < data.length - 1; i += 2) {
      final user = Map<String, dynamic>.from(data[i]);
      final bot = Map<String, dynamic>.from(data[i + 1]);

      if (user['isUser'] == true && bot['isUser'] == false) {
        result.add(
          Conversations(
            title: user['text'],
            subtitle: bot['text'],
          ),
        );
      }
    }

    return result;
  }
}