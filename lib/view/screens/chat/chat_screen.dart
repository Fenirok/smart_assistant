import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_model/chat_vm.dart';
import 'widgets/chat_bubble.dart';
import 'widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  void scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatViewModel>();
    final theme = Theme.of(context);

    scrollToBottom();

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        leading: Icon(Icons.menu),
        toolbarHeight: 80,
        title: Text(
          "Assistant Chat",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: vm.messages.length,
              itemBuilder: (_, index) {
                return ChatBubble(message: vm.messages[index]);
              },
            ),
          ),

          if (vm.isTyping) TypingIndicator(),

          // Input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            color: theme.colorScheme.surface,
            child: Row(
              children: [
                Icon(Icons.image, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 10),
                Icon(Icons.mic, color: theme.colorScheme.onSurfaceVariant),

                const SizedBox(width: 10),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade700 ),
                      color: theme.colorScheme.background,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: "Ask something...",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      final text = controller.text;
                      controller.clear();
                      vm.sendMessage(text);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
