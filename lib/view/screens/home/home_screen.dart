import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_assistant/view/screens/home/widgets/suggestion_card_widget.dart';
import '../../../view_model/suggestions_vm.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    final vm = context.read<HomeViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      vm.init();
    });

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        vm.loadMore();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        toolbarHeight: 80,
        //backgroundColor: Colors.pinkAccent,
        title: Text(
          "Smart Assistant",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5,),
          CircleAvatar(
            radius: 35,
            backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            child: Icon(
              Icons.auto_awesome,
              color: Theme.of(context).colorScheme.primary,
              size: 30,
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "How can I help you today?",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 12),
          vm.isLoading
              ? Center(child: CircularProgressIndicator())
              : Container(
                  height: 476,
                  child: ListView.builder(
                    controller: controller,
                    itemCount:
                        vm.visibleSuggestions.length + (vm.hasNext ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index < vm.visibleSuggestions.length) {
                        return SuggestionCard(
                          suggestion: vm.visibleSuggestions[index],
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
