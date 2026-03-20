import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_assistant/view/screens/chat/widgets/chat_bubble.dart';
import 'package:smart_assistant/view/screens/home/widgets/suggestion_card_widget.dart';
import 'package:smart_assistant/view/screens/chat_history/widgets/chat_history_card.dart';
import 'package:smart_assistant/data/models/message_bubble_model.dart';
import 'package:smart_assistant/data/models/suggestions_model.dart';
import 'package:smart_assistant/data/models/conversation_model.dart';

void main() {
  testWidgets("ChatBubble renders correctly", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ChatBubble(
        message: MessageBubble(
          text: "What is Flutter?",
          isUser: true,
          time: DateTime.now(),
        ),
      ),
    ));

    expect(find.text("What is Flutter?"), findsOneWidget);
    expect(find.text("You"), findsOneWidget);
  });

  testWidgets("SuggestionCard renders correctly", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SuggestionCard(
        suggestion: Suggestion(
          id: "1",
          title: "What is Flutter?",
          description: "UI toolkit",
        ),
      ),
    ));

    expect(find.text("What is Flutter?"), findsOneWidget);
  });

  testWidgets("ChatHistoryCard renders correctly", (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ChatHistoryCard(
        convo: Conversations(
          title: "What is Flutter?",
          subtitle: "UI toolkit",
        ),
      ),
    ));

    expect(find.text("What is Flutter?"), findsOneWidget);
  });
}