class MessageBubble {
  final String text;
  final bool isUser;
  final DateTime time;

  MessageBubble({
    required this.text,
    required this.isUser,
    required this.time,
  });

  // Convert to Map (for Hive storage)
  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "isUser": isUser,
      "time": time.toIso8601String(),
    };
  }

  // Convert from Map (from Hive)
  factory MessageBubble.fromMap(Map<String, dynamic> map) {
    return MessageBubble(
      text: map['text'],
      isUser: map['isUser'],
      time: DateTime.parse(map['time']),
    );
  }
}