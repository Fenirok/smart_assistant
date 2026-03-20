import 'package:flutter_test/flutter_test.dart';
import 'package:smart_assistant/data/models/chat_history_model.dart';
import 'package:smart_assistant/data/models/conversation_model.dart';

void main() {
  test("should pair user and assistant messages correctly", () {
    final raw = [
      ChatHistory(sender: "user", message: "What is Flutter?"),
      ChatHistory(sender: "assistant", message: "Flutter is a UI toolkit"),
    ];

    List<Conversations> result = [];

    for (int i = 0; i < raw.length - 1; i += 2) {
      final user = raw[i];
      final bot = raw[i + 1];

      if (user.sender == "user" && bot.sender == "assistant") {
        result.add(
          Conversations(title: user.message, subtitle: bot.message),
        );
      }
    }

    expect(result.length, 1);
    expect(result.first.title, "What is Flutter?");
  });
}