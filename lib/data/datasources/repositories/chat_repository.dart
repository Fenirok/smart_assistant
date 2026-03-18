import '../local/chat_local.dart';
import '../remote/chat_api.dart';

class ChatRepository {
  final ChatRemoteDataSource remote;

  final ChatLocalDataSource local;

  ChatRepository(this.remote, this.local);

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