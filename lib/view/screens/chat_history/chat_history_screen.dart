import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_assistant/view/screens/chat_history/widgets/chat_history_card.dart';
import 'package:smart_assistant/view/widgets/mode_changing_button.dart';
import '../../../view_model/chat_history_vm.dart';

class ChatHistoryScreen extends StatefulWidget {
  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatHistoryViewModel>().loadHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatHistoryViewModel>();
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 80,

        title: Text(
          "Chat History",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  height: 440,
                  child: ListView.builder(
                    itemCount: vm.conversations.length,
                    itemBuilder: (_, index) {
                      return ChatHistoryCard(convo: vm.conversations[index]);
                    },
                  ),
                ),

          SizedBox(height: 20,),
          ModeChangingButton(),
        ],
      ),
    );
  }
}
