import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_assistant/constants/theme_constants.dart';
import 'package:smart_assistant/view/screens/main_screen.dart';
import 'package:smart_assistant/view_model/chat_history_vm.dart';
import 'package:smart_assistant/view_model/suggestions_vm.dart';
import 'package:smart_assistant/view_model/theme_vm.dart';

import 'data/datasources/remote/chat_history_api.dart';
import 'data/datasources/remote/suggestions_api.dart';
import 'data/datasources/repositories/chat_history_repository.dart';
import 'data/datasources/repositories/suggestions_repository.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              HomeViewModel(SuggestionRepository(SuggestionRemoteDataSource()),),
        ),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider(
          create: (_) => ChatHistoryViewModel(
            ChatHistoryRepository(
              ChatHistoryRemoteDataSource(),
            ),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeViewModel>().themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainScreen(),
    );
  }
}
