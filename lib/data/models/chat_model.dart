class ChatItem {
  final String id;
  final String message;
  final String reply;

  ChatItem({
    required this.id,
    required this.message,
    required this.reply,
  });

  factory ChatItem.fromJson(Map<String, dynamic> json) {
    return ChatItem(
      id: json['id'],
      message: json['message'],
      reply: json['reply'],
    );
  }
}