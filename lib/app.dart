
import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';

class RecipelyApp extends StatelessWidget {
  const RecipelyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipely',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
