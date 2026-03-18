import '../remote/chat_api.dart';

class ChatRepository {
  final ChatRemoteDataSource remote;

  ChatRepository(this.remote);

  Future<String> getReply(String message) async {
    return await remote.sendMessage(message);
  }
}