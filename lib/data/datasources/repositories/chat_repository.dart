import '../local/chat_local.dart';
import '../remote/chat_api.dart';

abstract class ChatRepository {
  Future<String> getReply(String message);

  void saveMessage(Map<String, dynamic> message);

  List<Map<String, dynamic>> getLocalMessages();

  void clearChat();
}

class ChatRepositoryImpl implements ChatRepository{
  final ChatRemoteDataSource remote;

  final ChatLocalDataSource local;

  ChatRepositoryImpl(this.remote, this.local);

  Future<String> getReply(String message) async {
    return await remote.sendMessage(message);
  }
  void saveMessage(Map<String, dynamic> message) {
    local.saveMessage(message);
  }

  List<Map<String, dynamic>> getLocalMessages() {
    return local.getMessages();
  }

  void clearChat() {
    local.clearChat();
  }
}