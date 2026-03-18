class ChatHistory {
  final String sender;
  final String message;

  ChatHistory({
    required this.sender,
    required this.message,
  });

  factory ChatHistory.fromJson(Map<String, dynamic> json) {
    return ChatHistory(
      sender: json['sender'],
      message: json['message'],
    );
  }
}