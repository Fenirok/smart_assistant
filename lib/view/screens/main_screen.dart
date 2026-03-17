import 'package:flutter/material.dart';
import 'package:smart_assistant/view/screens/chat_history/chat_history_screen.dart';
import 'package:smart_assistant/view/screens/chat/chat_screen.dart';
import 'package:smart_assistant/view/screens/home/home_screen.dart';
import 'package:smart_assistant/view/widgets/bottom_nav_bar.dart';


class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    ChatHistoryScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],

      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,

        onItemSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
