import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_assistant/constants/theme_constants.dart';
import 'package:smart_assistant/view/screens/main_screen.dart';
import 'package:smart_assistant/view_model/suggestions_vm.dart';
import 'package:smart_assistant/view_model/theme_vm.dart';

import 'data/datasources/remote/suggestions_api.dart';
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
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
