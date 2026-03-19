import 'package:smart_assistant/data/models/conversation_model.dart';

import '../../models/chat_history_model.dart';
import '../local/chat_local.dart';
import '../remote/chat_history_api.dart';

class ChatHistoryRepository {
  final ChatHistoryRemoteDataSource remote;
  final ChatLocalDataSource localDataSource;


  ChatHistoryRepository(this.remote, this.localDataSource);

  Future<List<Conversations>> getHistory() async {
    final raw = await remote.fetchHistory();

    final message = raw.map((e) => ChatHistory.fromJson(e)).toList();
    return _pairMessages(message);
  }

  List getLocalMessages() {
    return localDataSource.getMessages();
  }

  List<Conversations> _pairMessages(List<ChatHistory> messages) {
    List<Conversations> result = [];

    for (int i = 0; i < messages.length - 1; i += 2) {
      final user = messages[i];
      final bot = messages[i + 1];

      if (user.sender == "user" && bot.sender == "assistant") {
        result.add(Conversations(title: user.message, subtitle: bot.message));
      }
    }
    return result;
  }
}
